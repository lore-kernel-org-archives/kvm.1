Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046522;
	b=OOfkqb5pcLux9nDBkTVU4i6rAyqP4IHIOeJGJzAt8DyAF3GzbMN/kAK6quo5VHIIZJ8E
	 C/wD36n0vmPfa0wdNqxr4OqBWUKmZEUKzhGxXpmMa5v1U1MpvIxYU2u//FXLVqxNFka/S
	 aSMRF2K/3iObBx+NK3hIFMkyudTJX7UEMOkuHHc9sQUageE0sYltcUZkW+pHHN8arPlPn
	 Je3L35myGK8ZWZj4Kwo1dpN5s6b10oYeOgAaiAuG9CnYaXZeqpOEWjnC3sHlHcPaG9Gte
	 qNsgYdqTwtjfap5oerANorEr5CDSPXlVlf5zFauXbpE3LbHm5mb5J6sbMfhJ9YogN2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZMcRdE0DWUvfvjny+MgYRY4V5/4F1cz7ADr3t9/9/Oc=;
	b=iIn9GXZIE4/VGU5l/WYOBqovpyN3KLiK9vJLKNqxnH/bFB9OaDtCK1rWPZMHhpfAi2s+
	 4ZGYIKX52YXeK7eKjtECDFKwUFl0DDiV8pJxP2lQc9SMEgOUThFbf/IIPyUXazYEk9vpJ
	 Hth7cL8iSQVzWnVbB0oV+UHXSsejtnlobTKGB1mdWfv13/hvrH3wYoIO3fV59FGGMV/AJ
	 rLKVC5WWp/SKdtOW36P3TGv3XxaI9ddBSMApL+DdLV/dV1nAIqcDIxR67W/3p4Bw1Pd+t
	 MI+z43Fq9km42snTKy5vLK42aVJ93hJsF1ikQ/MWYqvXBJ15DaDqBvQmQxDh+IzSnow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VnL5J7E3;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6660A263B
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED6660A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VnL5J7E3
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b37620eb73so2096497b6e.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046521; x=1795651321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMcRdE0DWUvfvjny+MgYRY4V5/4F1cz7ADr3t9/9/Oc=;
        b=VnL5J7E37p9U9QygnOqjiKkyG+IY3TThsqkVfJlyVBCOMMRYdCX9nngEyVIwDOGF7X
         hazEduQrQFeNkJqU9unCkvw+x3fHhHYS4qS4Tx7pcJOAni4UNVEeb5zXzA5kb+1GdKo6
         s2jCXYoJGQtw2NLJOgCXsyWEZ6KRPamW5NM72W0mj3R3+rtSy6RI2FYFh1MOLngm2YPg
         8JfpqdzaeCtylXIPwfcr5MA1ku91WqlM9gtdXXpc9vH3g0bJCawkk06w/Mmr5JDM/ItS
         ycu/1sbs7nrnAwUySq1i6TnI+v+Od0HJmmz9zTTNg43BT7y6DZYNEthgvkX6GkwURFXo
         Tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046521; x=1795651321;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMcRdE0DWUvfvjny+MgYRY4V5/4F1cz7ADr3t9/9/Oc=;
        b=zB3e2+M9AM38ZJpOF6nH/1W7LwX13zg0EE22fcUCS+gsRT2GzdDRR7Z9de0N1AVe3M
         trJZxIZWXQKl4jJTyurGdGCXdH887PYzUt5xBfSyIFAWoJLnUt4KXqbSm5rIDNgOAKFb
         YHNv6p44A9bv52npc268KRv0P/HjL78LVEbxgZIN3cpJ9eNB2gnKFE4c31Jr/h08Ia8r
         we7Thg7qomh01VJvptL57hhEkcqQLuFbvePkK0W17tXDnQtP9Z6RgzwHq23jDr8oKKJo
         AuTDzj0UNcZkWwz1W11eiH+rZAxH78yReFuFsmynXE9R0Mjjbt28cRuqwX8tohgM+jGD
         7yHQ==
X-Gm-Message-State: APuU4Z8525JX+NqxYT6M3rOKQjpjaBMo3B5MIXfSAy4ilOKjkEUd/0g3
	6d3asqYWiK1LaSXiBSdJCct7LiRRWMYgPDjReiwjLLVBaIZ8mz85rw4MiMiZbmM8ONpnzVoQGjz
	g13q4PT1Pm8gzwwdUswvWclqyY0434iQKOJlQF0an7BypV6j/Z0Irwsr0Z++8FhZWXpE3kYYD4h
	4pSUhxmPpk22hZesXcfosg2zagMokER6zrAhYZEPV/+HM=
X-Received: from iohd25-n2.prod.google.com ([2002:a05:6602:86d9:20b0:9e2:221a:fd83])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a19:b0:567:c773:39ab with SMTP id 5614622812f47-57742d30c1fmr4647260b6e.39.1795046520570;
 Wed, 18 Nov 2026 16:02:00 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:46 +0000
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
Message-ID: <20261119000151.442543-5-dmatlack@google.com>
Subject: [PATCH v2 4/8] vfio: selftests: Skip vfio_pci_sriov_uapi_test if
 SR-IOV can't be enabled
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Skip vfio_pci_sriov_uapi_test if writing to the PF's sriov_numvfs file
fails with -ENOENT, which means SR-IOV cannot be configured on the PF.

vfio-pci returns -ENOENT unless its enable_sriov module parameter is
set, which it is not by default, so the test currently fails during
setup instead of skipping.

Fixes: a6e4e726600d ("vfio: selftests: Add tests to validate SR-IOV UAPI")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
index f3a018b8699d..f27418fa5960 100644
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -210,6 +210,7 @@ static void vf_setup(void)
 {
 	char *vf_driver;
 	int nr_vfs;
+	int ret;
 
 	nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
 	if (nr_vfs <= 0)
@@ -220,7 +221,12 @@ static void vf_setup(void)
 		ksft_exit_skip("SR-IOV already configured for the PF: %s\n", pf_bdf);
 
 	/* Create only one VF for testing */
-	sysfs_sriov_numvfs_set(pf_bdf, 1);
+	ret = __sysfs_sriov_numvfs_set(pf_bdf, 1);
+	if (ret == -ENOENT)
+		ksft_exit_skip("Cannot enable SR-IOV on %s (vfio-pci requires enable_sriov=1)\n",
+			       pf_bdf);
+
+	VFIO_ASSERT_EQ(ret, 0);
 
 	/*
 	 * Setup an exit handler to destroy the VF in case of failures
-- 
2.56.1.708.g77570a6a1d-goog

