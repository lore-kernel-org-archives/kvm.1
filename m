Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4383AD522
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148925; cv=none; b=Quo9/0EEPNA4xMxx1t+adX3iYEh6tFByM/XZG8kjIqmssR7zK15swMKW3YiFtU2+nT4wUvVodO5OuSi8ndodL6d7c4Mv8VPjIdYWgfymr2z2cVW8R3Uw91oD2GsYc5SDYHIY6cuxb9fcZe3gAQbfn6TvZrMerI/GSLMfrcCpJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148925; c=relaxed/simple;
	bh=ty33vLeH1hO1KV5Aq52fEHjTt/ulAY38MlU61RE6Hu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJCuOj3NHy5Gz7aDxMGGlPiMxmu/FaRkJMQOhr0M32XwF7Hg87R0vaidz03Xw4NLn5CaeBbvZw9H2yB9mC8mzovF4WRVmAWOSnnAgyh1tcvaoZVivvFw5gH0IRjKWRBPC3SSkvEvH0zJ/uPoP4dYvMw1xiJxZXfFbPoB+lONB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A99ATjZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A99ATjZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky5o/xVx4bApMfBKfTqTU1xt2VCFg4tZ5G+RNDJxoJ8=;
	b=A99ATjZmB9IM0GkQYH8HnaGiRJobdpBBxc7o8QJ1rAU2jjooDRjwFcYcTtIJfIkt5crw+3
	La4pxjcoeQnnRQGibbGuaEcZm2XFqDEoIanLNFKCi0HeIdfpEuZl5ZfMoHLSWrXMhQN27N
	sGU+rnkGMWc9HT/U94Gk6U9+0BTNbfo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-mgfye2-fMTSCbheSipR3Kw-1; Tue,
 10 Mar 2026 09:22:01 -0400
X-MC-Unique: mgfye2-fMTSCbheSipR3Kw-1
X-Mimecast-MFC-AGG-ID: mgfye2-fMTSCbheSipR3Kw_1773148920
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFB118002D6;
	Tue, 10 Mar 2026 13:22:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFEDB1955D87;
	Tue, 10 Mar 2026 13:21:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0FECA1801A8F; Tue, 10 Mar 2026 14:21:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 3/3] i386/sev/igvm: do not reset guest policy if IGVM does not set it
Date: Tue, 10 Mar 2026 14:21:54 +0100
Message-ID: <20260310132154.2783257-4-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
References: <20260310132154.2783257-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Ani Sinha <anisinha@redhat.com>

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
Message-ID: <20260310094450.35861-3-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 549e6241769b..cddffe0da8dd 100644
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
2.53.0

