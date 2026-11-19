Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046519;
	b=t/YJb/KFctB2nrR9fE2zVcXmLoGFUMGpeollsp62hkWT36IPVekx1uQ8XkzxcwL/icwh
	 uEcZDsCdasi+oTX9NjzCCUQOVHHtK/vZ4+6WQBDiPmXyHUiAlzAD73G1tRdSba/XHSkif
	 Q6CEMCMOVHpwRmAu0NpXj0zn098yM7TM8egVTv+dN0nCk0BA+QYKeKHHB8MOR9/3qOiJA
	 HeO61ld8MywFPHecr94q1LdQcAK+7iulSnsOEw5TETRIXNantIsGINbxH83Xov8K5IsrB
	 2m7/pPvcvRll8iqMG5+uPLPzAHRNZb+BNCCkN0vqRfQBPt1k8vIfeTCydYpOsWNE/Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
	b=s0XiFAS3oefqgVH8RUmFf0jgRmZP6+1Qg1LNJIJFmb3OZdjL/kEYHRHCRjgmRPIK2ECA
	 1cYQI/vzk9fZf/6r5U79pNAyGT69osrxmhzZJDxUmODFPvQaGcoegWddSNca4fQ28s0mQ
	 K4m1aj/MZ1bnUm/bW8b90TZ8ygZVbBjRfL2fMSDetn4O1fGmpo1Pwwwupuxr97KMNpuyr
	 b2DaYwM3tUZDnZanUoutCaC/U/XEp8APvbNdROWnFpCuFp6O2Eb1X0KkWnQ/9KmERBfDG
	 3KeD0V7jcr0D70j+yIegND9ne4w3kA11kPfJHApSSQHVGTLfByOIQyXCsu7w/Ts4kEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nsRGs9Ga;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF42606A332
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF42606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nsRGs9Ga
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8255327a28fso1724930a34.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046518; x=1795651318; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
        b=nsRGs9GaEnVL8fDz7RDR30xI5x0zjXluUYy96pdI+goVmdQ/rT3JwxAmAhoLV7IDji
         FS84Q+VArgYKbMS6JeL5lnSR17EEK/kS8NluDXXIf5fdaK0K5/O4hA4LhOdIVwsQHusy
         tNa0z0tp7R9qIDPlxXbE45AY95n18rw2FY54ZBHmWxHVQHEbSMqXosjNYqECUWKhjng1
         Kb1rirxYgDO2Sg1zDFL9Ma0uNUMmPJH1ugn6x0cPwmpaRO8Db8iomGD0Tv/c0yl7CPah
         rIaMJ6cz4p4Hm9pWzg/iaGIZtw3bj5dZUCnbxRPsamBCwXb0jav8YU19AMB2vkXnm1rD
         hQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046518; x=1795651318;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
        b=bdhzbsJerzY/11mD2RkXhwEovm6FvoZHScUY/9uBGbqoQQFShxvFZz0lMgBCAh9UUd
         zx9vROC9mASNu0r3zvYcU0jKPMGrssENw0u2hscOgCcW0iGUdxGHF/x/fX4LECsqVGAo
         29o5vQQGJj/7XRoJQabdlfqlRhdfCyub72kbPHTzDpoIZawEo0o8WqAmZ5+c5P2hoPK9
         2Ri3rgAXtJUtEt8YSNbjnYB4URX8Zxt7AiorHt1X+sYb9UkJSughEaov1PA6aAFVlTU5
         jfH/S3MNl02Hk+5iKt0iEoUpU6ylxbgcT/nhtapgeFQmAZEp/G431s+HeCmXTU+dwzKp
         agjw==
X-Gm-Message-State: APuU4Z/1kFFBSdzjMG2lt5mRFxoPIWPlmLUy0kiELa3OutjGsEKvw95t
	hDegw6JV6JBj7Vz109CqRVELgPRLLLcUxNKy/peozSAZBzCHQ3YXNCzc3HC133q/33bWiP6/bTP
	fK1gf5hwsLzcYjgfl3w0tbxzFyX7GWHyI/uGVsAF/ZLdz3Hl9uqFzCeQpivqpM8XZ5gSgWQC4CY
	gQxUrgVI28Rz8yNX12yqy1qz2NZ6Q2mqTWipmhYxdTZts=
X-Received: from ioi14-n1.prod.google.com ([2002:a05:6602:c64e:10b0:9ca:d7a7:e72f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:518b:b0:4f5:d3bf:edf3 with SMTP id 5614622812f47-57742b303c1mr4468950b6e.59.1795046518039;
 Wed, 18 Nov 2026 16:01:58 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:44 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-3-dmatlack@google.com>
Subject: [PATCH v2 2/8] vfio/pci: Annotate lockless accesses to vdev->sriov_active
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() and WRITE_ONCE() to annotate the read of
vdev->sriov_active in vfio_pci_set_power_state() and the lockless write
that clears it in vfio_pci_core_sriov_configure().

vfio_pci_core_sriov_configure() intentionally clears sriov_active
without holding memory_lock, so the write can race with the read in
vfio_pci_set_power_state() (which runs under memory_lock). The race is
benign: at worst it causes a spurious -EBUSY while the device stays in
D0. Mark the accesses anyway to document the intentional data race and
avoid KCSAN reports.

The write that sets sriov_active is done under memory_lock and is
serialized against the lockless write by device_lock, so it does not
need to be annotated.

Fixes: 40ef3edf151e ("vfio/pci: Use a private flag to prevent power state change with VFs")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4289ec9bc32f..511dcb49d2f6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -329,7 +329,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (state > PCI_D0 && vdev->sriov_active)
+	if (state > PCI_D0 && READ_ONCE(vdev->sriov_active))
 		return -EBUSY;
 
 	if (vdev->needs_pm_restore) {
@@ -2393,7 +2393,7 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	 * state transition would at most result in an -EBUSY, leaving the
 	 * device in PCI_D0.
 	 */
-	vdev->sriov_active = false;
+	WRITE_ONCE(vdev->sriov_active, false);
 
 	mutex_lock(&vfio_pci_sriov_pfs_mutex);
 	list_del_init(&vdev->sriov_pfs_item);
-- 
2.56.1.708.g77570a6a1d-goog

