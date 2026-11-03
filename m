Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665331;
	b=fiCBgkxicU2hKD3nYPGV+ySMKVab5ekTLUaRQhKSBFYJVpPMSNn33KtyREBLZqWG733i
	 g3eZsFetD1gyAEajktP54E/7pviYVi4srnhO+NmXFfksm2+eEeudHzcVBxhgZ2hc6ip/G
	 FQjTfjZC/kcQWMSOA31Hjq80Y4sEH9LkMIw/DcWHVf5QEZfrx64AQZtkCdoXBu+10mjo1
	 BnzNrj38lA3rbsJDCVQ/PGava0jbJbFqwCs8nd9erN3DLYvEoAlmKbL/izp8E1Rodufu4
	 LB0oG1DyALaYSWW4q05R8oW/P6D7NZXMhQ+QkMUNqRkrTupk/VHEuByldwt3Ud79yUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GnhmkL3sHgBajA/tFiWhkmxN54BhG8qxI7na8JnF6t4=;
	b=nzrMsoN7TQVq4Ao4xOPBNDFy4om3OZlZ5NJfOaSqiorUuCNeLdcCbr3QFn3k3WuLmdjf
	 srpuZo4KtlOkTjDiHHOc+ByLVMflI/UvakSuBshsuGL5yadiOkFyqKku4jkx8RmFN0wIF
	 5H8Ewglg8cJ9eUG0Jlou99V6uIHKmPuvUWpskaaBl5zG87XdbjaelHn8B66jGvPYlvfpU
	 QggH8SoYsCQrurODKjHaI8G7ZrzLRlfBYLlXCH+PfZ3d64gsf6GQN+fUx+bHRXugTgNT5
	 xPZ4/5c9XLhsiJt8fpI1SIXEDlj8ygWzbxYdF9bCQ9AERU4t63EowhOVsU/bpioRbNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLf+Y9s4;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE09606D80E
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE09606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLf+Y9s4
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso4715086a91.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665331; x=1794270131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnhmkL3sHgBajA/tFiWhkmxN54BhG8qxI7na8JnF6t4=;
        b=DLf+Y9s4cg8dY94ixNKufGvp9EgW7E1eziXIR53jM1PZL7X/tYfWWjwG0JdV6xCBZ3
         6mtDWr7KQ6SEGwZfIosZkL6rAba736wMqqE2ABQMe7PvimSYBt20AEtAlptUUqQB4Jeu
         nyL09EIMOW8Fcu4vr/I1ZvjUjegTCY5c6rEhKA/NulQtqGGfEKSePP3RYcEVMQKOOEjq
         Z1byyCmG5XttNdcTvKK31CPRdMeNEmGt7agUHhOi/gDJgSi5LknPJGTNqQqSoPA1MGiu
         EdCMs+1XhgkQBU6zARfTLJTGaT9lo5I4MHKDS+bZEhTZt2W1ju6QF2J30wOhhtvoZuAL
         3Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665331; x=1794270131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnhmkL3sHgBajA/tFiWhkmxN54BhG8qxI7na8JnF6t4=;
        b=XkbRBNaNQtgumy+RKTW7GEEJA3+J9MWNDElPRBJPL5gDgxE2CZjBvW2my8m6hwqfdo
         qZS49IBjIt8SNtze0xZHdkgYf7GeFGw3pa8aWndFR1TiUbLwlWggaUfWlfdY2a6NnigW
         Bc+ywSu9tEf3GMH7Zzv7nx1RsoY44ltz39+ivcivm79jG4smu0+bX5CnXCUflbODXVRs
         u/Ir1I4VMcveXvMMCrK6/EGFOhFiWiJAhX6biJ3L5+wVXVrV8ZXPdcWphg2vW/tvocQh
         D59k9aJ1cYbEHbq0VUn/6iQh6Nt9DEFAXPPIe/2B3vov/E6ZQvnXt/r4Fy/fwCsuy267
         wl/w==
X-Gm-Message-State: APuU4Z/pmCLzy+nOiYbuhdWvUASykJp0VLFJPjABiqrUzOtmKWfNDVgU
	n0MMjAR9FHyjLVbnacyPOHp3nOk3g3HO/9z7nyJTW4fQfogn5AKdH2Ap3naM0GamrRPfRw1Z6N+
	NjCzjMStnnSE2PDFucubk6jRYzUauRfLhxHG1ZJ00uGDEvezEtJqMQuuI2ga30oqAvH7Bkw15kU
	8v1Np3QIVgz+Z4nvcnpdM6bA1FkqzyDW2XuIcw01DsVaY=
X-Received: from pgbx21-n1.prod.google.com ([2002:a05:6a02:63d5:10b0:cca:8b09:717])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c8c:b0:3ac:c23f:cf51 with SMTP id 98e67ed59e1d1-3ae8983126bmr10794595a91.49.1793665330510;
 Mon, 02 Nov 2026 16:22:10 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:03 +0000
In-Reply-To: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103002205.3348519-4-dmatlack@google.com>
Subject: [PATCH v2 3/5] vfio: selftests: Print the known IOMMU modes on an
 unrecognized mode
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Print the names of all known IOMMU modes when iommu_init() is passed an
unrecognized IOMMU mode, and expose the list of names via
iommu_mode_names() so that tests can also print it, e.g. in their help
output.

Users can specify the IOMMU mode for some tests on the command line (e.g.
irq_test -t), and so a typo or unsupported mode should tell the user what
the valid options are rather than leaving them to go read the library.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/auit0kVkAaWcNUvk@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  3 +++
 tools/testing/selftests/vfio/lib/iommu.c      | 20 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index f204c71494fe..42d1de742c0c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -51,6 +51,9 @@ bool iommu_mode_is_available(const char *iommu_mode);
  */
 const char *iommu_mode_unavailable_msg(const char *iommu_mode);
 
+/* Returns a comma-separated list of the names of all IOMMU modes. */
+const char *iommu_mode_names(void);
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 526bb21f2766..64614325c49b 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -90,6 +90,23 @@ static const struct iommu_mode *iommu_mode_detect(void)
 	return NULL;
 }
 
+const char *iommu_mode_names(void)
+{
+	static char names[256];
+	int i, len = 0;
+
+	if (names[0])
+		return names;
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
+		len += snprintf(names + len, sizeof(names) - len, "%s%s",
+				i ? ", " : "", iommu_modes[i].name);
+		VFIO_ASSERT_LT(len, (int)sizeof(names));
+	}
+
+	return names;
+}
+
 /*
  * Returns the IOMMU mode with the given name, or if iommu_mode is NULL, the
  * most preferred IOMMU mode that is available (or NULL if none).
@@ -108,7 +125,8 @@ static const struct iommu_mode *iommu_mode_lookup(const char *iommu_mode)
 		return &iommu_modes[i];
 	}
 
-	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
+	VFIO_FAIL("Unrecognized IOMMU mode: %s (known modes: %s)\n",
+		  iommu_mode, iommu_mode_names());
 }
 
 bool iommu_mode_is_available(const char *iommu_mode)
-- 
2.56.0.385.gac671c819a-goog

