Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4D4CA272
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042132; cv=none; b=R38PrhAce7ssCyYvxR7meOOU4PdCuQ68UlV1LH1cr91Lf6HdPgqJ6dhh17bm8gUEptWlqhCCxkwHcO1yzJXRmMSH79FSb9JtcjRg4ks15F1gQaaBhPkbm0S/VzEGA+gwk2TZ/bVdj8x4ale701vmuUwYuIeMEuGlaEyBbkgwIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042132; c=relaxed/simple;
	bh=qNh2OB7o9DY+fchan5SBAgPmk4q+K1nnzSrJogXCq6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fn5nwDRGApylmc438QQH+hPV/d7k2hgZaSnuPxRn1DQuwlTOjq0+cc9QBTWB4lo7M+1Zv+vsrrWgBfur+oPT1d7FXirgCnpQVQWSEUSgUbZxFEq2bqQKRe6jNOZujUdCYF6blfwz6UEFIqO6pzjrwRlKBb9otNeWAchVjb6GyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpkYYYAf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpkYYYAf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1240243b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042129; x=1784646929; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcpQuk6vjGQSe9CsOI/pxanFsfOSXhryIEYWt4/hbIA=;
        b=cpkYYYAfmMzDHs0nc3O/FTomvuJ7iQRO9EFunIBdLjddq3HRe6dHFNletndhvkfMub
         k1+Dat20s9WImy8KxaxOMpYuTgGG4PgbsB84eWmNwQ0QJGM5G+0ABVVGbURsXBemGT6d
         wWxfsYZqDlW94p5TcS8dpCv0oEInhoVnhdZ17CZ2FUE/G4MCinThX2TpWx5lQRwDFx9A
         7zxMltZ3chK/4YQc07tIwv0qH9vIEzQYItdGp1Fv7nbkjwLPZ2FPqLxqX0SL7WJNjDNH
         l6zsQUsOg0TEOSDitFnBJD8PKzRovgdpPl6jRKbZkzTmHdiY2hle0HAHbbZVYL3gr/7O
         FaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042129; x=1784646929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcpQuk6vjGQSe9CsOI/pxanFsfOSXhryIEYWt4/hbIA=;
        b=SmRqBS8laaK+GQUm2SgeUHMa/Mvy1ueISaY9W2pZwr5fNoJROPThvINVcFIjjwV1in
         MjIdV4P9d2qgUmE86wySddZCvCf4NIYvUmc7Hpwj12+n1wVUEyXnnf9Q5r++4BBPJjnU
         5GHavtJXyJsi1tdp8arL5khYCfg3Dz1PgGpfD6NPjDMQ25MLgpdpAXAA2KJoslwpWeO8
         oI66IDXFTgu9eSZpDMPwIH3sMPUs6AeG8UQuGoPsgkoCm2Vht+DdEKc4HcZucl66tkY+
         nBFQE5zdMXI5drCvwz9sz0kxL7aPl7cV8mkZWGiF8+C/r76CCpjCogxpQzHFZkJx3Gou
         lvaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2V/8E0o8aFScNyVsd1+9kLLI+AS8J5R3uxtmVeIOU/CLn7BBRuXXxm11YLOrKAlE1X7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5zJiNhUy+di9xRJ2gCIZQSAbjd7A9K9D1KFu07OYzlG19Gx1
	x7NcvbIyw5+mo1q4P45BaMO378gI51xan/rgY6k8vPNbM8sjzv8Y8u5RPR3d8se6uzpAGnXLfAs
	muuJajJztSQ==
X-Received: from pfx27.prod.google.com ([2002:a05:6a00:a45b:b0:848:5415:1869])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8a:b0:848:70e7:f053
 with SMTP id d2e1a72fcca58-8488980f75dmr11709317b3a.54.1784042128707; Tue, 14
 Jul 2026 08:15:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:03 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-19-vipinsh@google.com>
Subject: [PATCH v5 18/20] vfio: selftests: Expose iommu_modes to tests
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Expose the list of iommu_modes to enable tests that want to iterate
through all possible iommu modes.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h | 2 ++
 tools/testing/selftests/vfio/lib/iommu.c                 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..4b9cbe262159 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -15,6 +15,8 @@ struct iommu_mode {
 	unsigned long iommu_type;
 };
 
+extern const struct iommu_mode iommu_modes[];
+extern const int nr_iommu_modes;
 extern const char *default_iommu_mode;
 
 struct dma_region {
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..95a494f829d2 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -23,7 +23,7 @@
 const char *default_iommu_mode = MODE_IOMMUFD;
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
+const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_VFIO_TYPE1_IOMMU,
 		.container_path = "/dev/vfio/vfio",
@@ -49,6 +49,8 @@ static const struct iommu_mode iommu_modes[] = {
 	},
 };
 
+const int nr_iommu_modes = ARRAY_SIZE(iommu_modes);
+
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
-- 
2.55.0.795.g602f6c329a-goog

