Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6B430CC0;
	Wed,  5 Aug 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927829; cv=none; b=sRduvTX3RqQP9786uPpNJy+cNt0K+zyrEsu2Ce4lo1Tcz7UcqWd8ag+W7fnYuK29p+dNO9UDsvoOh7VbeloigjDpk+XuawWETM61tfJK6q3TJ8fNtVWq697UWOjxnZ0/sFYYZJnw9HHRuyQAh70zKTBYxPjyNuI+/AldsoR5Yko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927829; c=relaxed/simple;
	bh=mWlBfRBicvr9Sp/4GK1gHvtyrXEItl+YRYkQ6JZlR/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1PPqnI4ltdDyhNpLK+xut4s5hWlEu5mkTZyWVhgq9hM1KNbTwC1BZ3kR32z6gnAp0/yKW0h8FF+HkWOWoagURkSXss3A5DSfBskkzCwo49s23mkgz2usSeVQGKhDbQoUReiX8xCvdEOzCTRfpuRinGjnRUKNzoanpW1DwAXwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PQjbxCLh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PQjbxCLh"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7128A20B716A;
	Wed,  5 Aug 2026 04:03:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7128A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927804;
	bh=GdugUXgaw/RRxSTb02hZRqyEZ8o4eEzaX+dPB+NEUjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQjbxCLha3GNCGWoMc6FrQRIw0ZqcYGqe3Yv9cp8t7mHodaLU6tqW9uEA+fII+bbw
	 1C/uaybt57CvxxOCMHUPCtIlR0SN0hz17F0UCE/Sbgxv6ULogiMwKAJzE4RCvOTUV3
	 CoDoCi4bsidQtc8CidTH3Q19u6fLMlmu4v8274dk=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 04/42] Fix compile errors
Date: Wed,  5 Aug 2026 04:02:46 -0700
Message-ID: <20260805110324.25067-5-snambakam@linux.microsoft.com>
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

From: Sriram Nambakam <snambakam@microsoft.com>

---
 arch/x86/kvm/svm/avic.c | 2 +-
 arch/x86/kvm/svm/sev.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 58e493a80cb0..251e36f5f0f7 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -404,7 +404,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	 * fully initialized AVIC.
 	 */
 	if (id > max_id) {
-		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
+		kvm_set_apicv_inhibit(vcpu->kvm->planes[0], APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
 		vcpu->arch.apic->apicv_active = false;
 		return 0;
 	}
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fe5e05e2162d..79fee7ebc19b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -569,7 +569,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	INIT_LIST_HEAD(&sev->mirror_vms);
 	sev->need_init = false;
 
-	kvm_set_apicv_inhibit(kvm->planes[[0], APICV_INHIBIT_REASON_SEV);
+	kvm_set_apicv_inhibit(kvm->planes[0], APICV_INHIBIT_REASON_SEV);
 
 	return 0;
 
-- 
2.55.0

