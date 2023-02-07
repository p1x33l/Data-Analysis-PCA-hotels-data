import numpy as np
class PCA():

  def __init__(self, X, num_components=5):
      # Data normalisation
      mean = np.mean(X, axis = 0)
      scale = np.std(X, axis = 0)
      X = (X - mean) / scale

      # Covariance matrix
      self.covariance_matrix = np.cov(X, rowvar=False)

      # Calculate the eigenvalues and eigenvectors of the covariance matrix
      eigenvalues, eigenvectors = np.linalg.eig(self.covariance_matrix)

      # Sort the eigenvectors in decreasing order by eigenvalues
      sorted_indices = np.argsort(eigenvalues)[::-1]
      self.eigenvalues = eigenvalues[sorted_indices]
      eigenvectors = eigenvectors[:, sorted_indices]

      # If num_components is not specified, use all the eigenvectors
      if num_components is None:
          num_components = X.shape[1]

      # Select the top num_components eigenvectors
      eigenvectors = eigenvectors[:, :num_components]

      # Calculate percentage of variance
      self.explained_variance_percent = [i/np.sum(eigenvalues)*100 for i in eigenvalues[:num_components]]

      self.cumu_explained_variance = np.cumsum(self.explained_variance_percent)

      # Project the data onto the new space
      # X_transformed = np.dot(X, eigenvectors)


  def get_all(self):
    print("         eigenvalue | percentage of variance | cumulative percentage of variance")
    for i in enumerate(zip(self.eigenvalues, self.explained_variance_percent, self.cumu_explained_variance )):
      print(f"Comp {i[0]+1} | {i[1][0]} | {i[1][1]}  | {i[1][2]}")

