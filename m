Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3F42EEA7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079775; cv=none; b=bW0APXHhOyyuUD4PpgOLVzuUhtbFNfvLCyPmIITYbsGuhBiwJlq41T1ZsexA6omZaxN/hhVJanw47F+V3f2dRdW89KDFBxhHF3q9xbDjgk5r5UyIJMMwww5+cB2PVe78Gbwi/pYPLmq6KQulgDcjpC8hteXQj3qkdqsAWLVfe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079775; c=relaxed/simple;
	bh=OJPzTAm4OBNQKBdHA8sxYljhi4riTjeTUbJrve7Bw2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELrr8s54lJ+Kx3lXWwrHiMPNMdYo2I5CqSu5v0FXH7jqDQ/ZsYExXsg9YxT5tCp3jqlVggPu3vFtLiDpqu8jAAl6XhKDMKF92suVE0GVbYZLkzkz1uG+/mr7++yX5eqUK8/FrVcPJha5EimeQgDhgYk3fVxmnUuFc39LeRnDjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEk4wLHu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSWAkN7D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEk4wLHu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSWAkN7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
	b=WEk4wLHuVzsPpIzStqGm31MnDr0ypAMoLwBjDIaph7NI4Q4TTJPook/+LANU53zvGqFvfU
	d1hQPtMc9fp9oaBDxjdHOcwWQeT3u8PFFjbkqKlWphncAEB34UfoE/dCK21kRPpZV1UwuG
	ANtMyFwCm3zbg0CLm1vXM9NGxoekX9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-YpElEue0NUKI7mEut0t7Lg-1; Fri, 29 May 2026 14:36:09 -0400
X-MC-Unique: YpElEue0NUKI7mEut0t7Lg-1
X-Mimecast-MFC-AGG-ID: YpElEue0NUKI7mEut0t7Lg_1780079768
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eecec7667so1134947f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079768; x=1780684568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
        b=jSWAkN7DfB6x1Vcxolq+TqWu77MFOxhj6pUgpOynzulOAEj7xXvfECp78ZkUrtwJi7
         euHl/POuu80ZgN04lxmNE60+l4HYRcj+Kkt1Pg2yEMGH/y09rLTFCPsx3RhSsv/rgNVh
         1ix/ACTdxLHxnJeshPAHpjcoG8CKU7H8kRq+GTy1RfxU4VCiSGpgYZn9CEUoPuGENKnD
         rPC2oLBhPo/g5dvi33ooL6iWIvZ2Pj/ghUhpXCzKGLebyrn9jrtGMAv42gUwZ6LYlzmN
         C2oCTTxe/z8SU4miXKdp0U7tdVghIXgH13t85wvFiMMF2+7enK4eI2VIjCQxZllWlmMv
         i4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079768; x=1780684568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
        b=m538uc0BSJnRzi3YHHbyqsFsJ47ct2BzGclpKJUE2fzwrJtCkMis1hiqW/Op2Lh8Yb
         hjLlmL0JiRiPpQkSKOhpURDoVa+0f5HcSSLItA9EaF3QYotrsfDt/VflFzuIG3vBYZux
         ccL5hpV78GhnMkEmq63jVRe/L+E4eMLdc6WpIc36mHifihm1Vbxdrx9W07SSl/gWGeO5
         7fmt2Ug9ndAjd9YDSA/IfWJHc5UyryrX2SPJoBNvzVGwxOvnUkwLLyAhGsANETxEV+yF
         aM3qRCx4zjwan6I/upY+tf7GfGFRNFk7p4w5ggw2+oDG98ecD2d0XagK4W47KvcPZA/m
         j4mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/o8Z01kvZ8h16C/OcCcaPcl8xY29+8I6k6RmX6zwZGnLJDV15l7KmkPJ1+F1WdBAW3PMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpi9sLKzVK6M99vy4TtOg8g192Duv8a8td+0RGeTfF6AHcfNH
	Zon2gp4k7WjvgPYSz41QYC4Ntm7LUIKykNIAz7nVqWvMIbFtEdlBDi3oY7qvLGSo2TvErdh/oSM
	ojeCgfN5TmYZbQ8sfiwYP3oo3e1B1mw8Yla1J8K8PbPBORM93sa0B2A==
X-Gm-Gg: Acq92OFi6R8BH34yolvsMq/o7qFpTo6ZPAWjxJWTHHDzXbhgw2bJPLPdZ9n+MN1Sv3f
	O+AF7UJikoB6JzEkyBtwlfmf6SyGYVFTaodJjSVTuAFsU/FidplgswpDuF0cCgMKasDw+r90umt
	4bYfj5MwiYwO/UUgekx8g57T3jSdvInN5PeS1BgZ85HPsmjBBe9shh3TnfRgEmMpbzdim1NjGIj
	JByCNnPRa38ps1Dh4Be80OmHpCKZqjDyxUkG4BKTIra8PTEi9KSk3fCtfb2JaEtcr7MiUGCw1BM
	J0sSdTr7H3rrJtTSpP09sDH6Fk/dM4xVf3wVgm6m4PxwaAnKWC/j8XqLu+7hCT8X3iJwp92YyIP
	JSBTNN9yIozFfmgAini5fQxVXi0tj7U91LzyoCVAaP44PgMvln44PRNDw4SLBNFP04J8kdLNVuu
	a7rbuDn/21TE1PBb++Uw2jDIU3lASdETq60u/dwg==
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490a28d390emr15119045e9.0.1780079768349;
        Fri, 29 May 2026 11:36:08 -0700 (PDT)
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490a28d390emr15118485e9.0.1780079767918;
        Fri, 29 May 2026 11:36:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c967c6csm64118605e9.2.2026.05.29.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 07/24] KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
Date: Fri, 29 May 2026 20:35:32 +0200
Message-ID: <20260529183549.1104619-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Now that all paths in KVM properly validate the length needed for the
scratch area, and are guaranteed to pass in a non-zero length, WARN if KVM
attempts to configured the scratch area with min_len==0 to guard against
future bugs.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-8-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6072fecfe994..a3e85348ace9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3669,6 +3669,9 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 	u64 scratch_gpa_beg, scratch_gpa_end;
 	void *scratch_va;
 
+	if (WARN_ON_ONCE(!min_len))
+		goto e_scratch;
+
 	scratch_gpa_beg = svm->sev_es.sw_scratch;
 	if (!scratch_gpa_beg) {
 		pr_err("vmgexit: scratch gpa not provided\n");
-- 
2.54.0

