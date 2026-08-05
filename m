Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10B46A5F2;
	Wed,  5 Aug 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927854; cv=none; b=T3+G3A6OyO70hLfTHjf7cv+zq692Pt/S3Efnwsn3aVBOOIM2hY6+IDRf/25FQc9bp9HAR8V5vd9I3tdTsRgWkjFXxbRlPA4BZE4jm6uhchLc6agh9QNxoN7PKxCpaWP3zrGZ2b7lPGWEo5gKmTzgYzLOgIrXdJJ7hUfYl79Q0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927854; c=relaxed/simple;
	bh=CMtQOBxsOyZafsRq9Hm/+RIAhu7pzUJUx0wZ70Pn+qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anso/W7X+S+jIrGR7EgxoSdpASDlfXkm5cB1OoaE4283rDLu3ayBe2XHuexuVrDIXUdngde2/ILdZEUiR01ycnJZhXTRwkRmYfe5sMlqcgUIm9ICNdAdNKT01/3PYUXsUTXQ17qoUe4BXkEAXAMI/0s3LdhWbjbzNNtex6gqJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ptqwnP4n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ptqwnP4n"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 703A420B716B;
	Wed,  5 Aug 2026 04:03:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 703A420B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927832;
	bh=sI2sXVp/yDVu/Cytrm86fNxGZAmR2vZkYQFR/0LYH8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptqwnP4nE71RqbshWWQTSPUb724PWfo3h4jWJQ1rQmspZmSAZ54+nGmQsODPrqLn3
	 HGa6y//yfmt3xJoUAeSsCRDCgaxyLgfA3tmd298neLoDt56lGmEuKSV/yJuwn4Hayc
	 ntfx8/TaAJsQHEZ8mPVOOhbSFfoWkGvTS4FOHKps=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 36/42] KVM: plane: handle KVM_CHECK_EXTENSION on the plane fd
Date: Wed,  5 Aug 2026 04:03:18 -0700
Message-ID: <20260805110324.25067-37-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A plane file descriptor did not implement KVM_CHECK_EXTENSION and failed
with -ENOTTY, but userspace needs to be able to query capabilities on it.
Forward the query to the plane's parent VM, except for KVM_CAP_PLANES
which returns 0 because a plane cannot host planes of its own.
---
 virt/kvm/kvm_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3a1a09f26340..6e4f3f3e6881 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4946,12 +4946,21 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
 }
 #endif
 
+static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg);
+
 static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	long r;
 
 	switch (ioctl) {
+	case KVM_CHECK_EXTENSION:
+		/* A plane cannot host planes of its own. */
+		if (arg == KVM_CAP_PLANES)
+			r = 0;
+		else
+			r = kvm_vm_ioctl_check_extension_generic(plane->kvm, arg);
+		break;
 	case KVM_CREATE_VCPU:
 		r = kvm_plane_ioctl_create_vcpu(plane, arg);
 		break;
-- 
2.55.0

