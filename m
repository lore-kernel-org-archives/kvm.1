Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B244105E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135914; cv=none; b=U6Ah8ehrieOfZ8yO/LGU3Y4bG+ppeHigf4y0xQI9D0e5f8TWwzkjjcocE3vsEKYXgtEn3OAB3ARMPlptQNUfclKMW4XRhAT3qDs9Sh22ywJG9IuTOQ3nkqHSkB28PSHaWJnWGFJTTy5cASi4vfuFjcvQe8LBaWSbiSqD0pJaQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135914; c=relaxed/simple;
	bh=B7dmRKd/Tej5fhgZ4VKAZhTWmwzjeZ5fKPb4f6xty64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSzPTf5/56uhtGwoxrKgCyYiwQtNw+rqBxzE7iYnBkiYQ73w5DUJsAXSbl7l73TO3XdWW9z2/Lhzq+K++y4006keyV3ziLWWSdzcs/lBZWk1cE0zDvMZQXmzT/ZinD1hPfpKEs/V9VTeIqdRHkjuFxslUbWQ17F7GTiiS/IWCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibc8AJSd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aubCKneC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibc8AJSd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aubCKneC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773135911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
	b=ibc8AJSd5wmTtpnx8EUWiP40OtujJHzy6IuQeeW3OC7PTsBN4iQGXcCcqPHH52NwmgyRSk
	ijeJVCrMXqUrUvJde00G4mxKsDnrlg9GWQ5NxlwgerQ6CYdHkodOAuyPsLnRHXuTVKRuI1
	5gHDMJ3mNv4A39nUECGKxLLAyBoFz+Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-LR-C-TuxNFasb7A4-rHB1A-1; Tue, 10 Mar 2026 05:45:10 -0400
X-MC-Unique: LR-C-TuxNFasb7A4-rHB1A-1
X-Mimecast-MFC-AGG-ID: LR-C-TuxNFasb7A4-rHB1A_1773135909
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829ad972df6so1521612b3a.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773135909; x=1773740709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
        b=aubCKneC/2vtMGR6+zSNaqJtHsYsmlu6J1LXCH7kWycfhRQOPCvEF/qddy6504FcUw
         u3XQ/ObPZ12Yw7Z4wKpAAhs8CNwvi6vjHE1Lnrc3Dpl8awMhCZuDMJcpuq0BGgBbkDHr
         BCNMKomf7P/151nc8i/Y2upzZReIewY9XmskeCUWlURBA1iqakdLo7ScALsDXHIu4dWG
         pLyd+XW8vNwUB1yeSgsoQ5Utb+KuQvcnEgkAgM5FQGp2s/GTSkcbAyBuUqK0NfBohY7E
         oQ3hPqJjlUhY12zfNAnuN8QfUlDsUUftFXCj4OgwUHiNYHF2D8vQ+KecTA13gjD/6dKR
         qP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135909; x=1773740709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xCt7/ib1f44HpeDHXqi+BBxuN/RBrwTUM11Ei+wkzw=;
        b=gT85VUEAjHyzTV6PggBi3jERovIzZNAsfkYfrvvyLX0iGT8VazSI/MLXdHXmr1tZy2
         xTSTt7eGdHoltgOWZnxnec1nLTUPRZYxvUOuF5PjtA3WRhAkTmO2UMGHfZpEXlO5GBg9
         /7TCl9S+/i3AXUce6GQbbNrkmz62FgpqVov1+PZ3QeVKh9Nt0hcnm7dDh9zCHbo64uOZ
         oBf4PK8ESpPJM/E4lA6I6K7uh0imDRtiBHSuh+n80SSUHQKZMhUBItF6SJCImeuGN++U
         Opiws+VVC7oXmlioeN9RlTpxGfi8sg8ezCeSGQZexj9kUwEmOvywATVEsRd/oTGqSIfR
         nxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2j9ogpLNXm0ckvRf56a/C/kYhYXEtbafdSPw/01Ib+jcEHLQeD1Z2tguWvIYX6Xq6dws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeO+yQpiye7UUeDZzVMndirVCwBxaOTAEgz7ff00RJPpnPj3c
	mhsMytWndjS1LshivkboQhI/5zOcz89zXWKevdE0QruBflSlYYoq3QS7eKXqmlRT339lihJKNq8
	0b9OSkK8uLj60WUjohWVe0nxPGVO2c57E27hmnVAixY+NTq8EkUI6XWRRa42yfQ==
X-Gm-Gg: ATEYQzxudC6PryTV5oQckS1sREFq5RmnL4XX9ey2Pd1gRLqmMBgOvdHusHQcwWbY8Ta
	+0YN7tblE3XHmROm3NyZ9+KE5P6750yqAyX512wUbhb3WKH0FiNijSCYARRF6kDjnfMVAb3cjrL
	haMAkx3/8iv/NMf1wZsyROK+l7/H28XjbvL+eiv+AYE18I9nJFkis1Fno7NtK+BHOIJn6hU/0YN
	KnTg+4VtM9w6nx8BKdxe0PXtBseKvqQTHQXNuch/0rTvIOheNN/gv6drjlWxGP/2diU0t5NDWOS
	/42nR9KVwsnJ9EU58fbjrmuUdXKi50zujMdmXd3hyMVGllIcrNN0dvzSd4sObaGNf8Dvl39/yo0
	zORY3czkLbKziX/Qz8tthWG9LugG2O1myv/3zEC6wN+5qAP60lwnMJWA=
X-Received: by 2002:a05:6a00:928c:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-829a2f83f20mr13463946b3a.48.1773135908717;
        Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:928c:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-829a2f83f20mr13463914b3a.48.1773135908298;
        Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-829a4636973sm16566142b3a.3.2026.03.10.02.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:45:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for 11.0 2/2] i386/sev/igvm: do not reset guest policy if IGVM does not set it
Date: Tue, 10 Mar 2026 15:14:49 +0530
Message-ID: <20260310094450.35861-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260310094450.35861-1-anisinha@redhat.com>
References: <20260310094450.35861-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The guest policy is set either through command-line or through IGVM. If none of
the above applies, default guest policy applies. However, if IGVM does not set
the guest policy, currently the policy gets set to 0 regardless of whether it
was previously set to default value or command line. This change fixes this by
checking if IGVM indeed has set a policy value. If not, do not reset existing
value.

This avoids guest crashes such as the following during reset when the IGVM
has not explicitly set any guest policies:

qemu-system-x86_64: sev_snp_launch_start: SNP_LAUNCH_START ret=-22 fw_error=0 ''
qemu-system-x86_64: sev_common_kvm_init: failed to create encryption context
qemu-system-x86_64: unable to rebuild guest: Operation not permitted(-1)

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 549e624176..cddffe0da8 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2760,7 +2760,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                 id_auth->author_key[0] ? 1 : 0;
             finish->id_block_en = 1;
         }
-        sev_snp_guest->kvm_start_conf.policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_snp_guest->kvm_start_conf.policy = policy;
+        }
     } else {
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
         /* Only the policy flags are supported for SEV and SEV-ES */
@@ -2769,7 +2773,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                              "but SEV-SNP is not enabled", __func__);
             return -1;
         }
-        sev_guest->policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_guest->policy = policy;
+        }
     }
     return 0;
 }
-- 
2.42.0

