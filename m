Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221403F65F9
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186555; cv=none; b=ug8b3wPKNyCcFb3KYQxVC4cafnZbcaiEmq4rFZcwnlqwhzdk5xr+KNOrg9B6ucY8ldDa6y0ApcT1qrECmZFjivKSzZ/DEaY/Ktjyjwn/VqQXwfat3AGewUc7AF16FmLTDQDJcnktCPlgvDud7ATle+w6v7Kg7lL8GZnkEl+B7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186555; c=relaxed/simple;
	bh=wxT6ANPDWoUdiA3RflJKhdUGnjSjqmEv68Sd9E4VFWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l705sr1nHgn+TO0wqc24OkID5j3N0GFi7VRaDxxYZVeQwh52QwF/upd+wM4Y20zLLFAWuDE+M1RYCLMFoSZ2CdWwDQCogtdZ+0wN8dKpbbG/HwZt4ugpj7IW+KhERz9OfuMGnTH3UVacO0/I1dlSL767atm5lWjWfQLlu8nHrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUXsVkUp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUXsVkUp"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82984468f85so3415131b3a.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186553; x=1773791353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S/oj221AyjL7p0LimTIXezs2T/jJm5OAuCv1irweo4I=;
        b=sUXsVkUpLTwMDzrrM91zSWBX9YLV4diFt0ij+vfW6YHRQnIaoQw7iUuXDfkdd0NqwM
         wPT8jZ1m13YMCirOLrT5LrRP8ivTrhUjmcC81rPeXo3yVGNS3e3WiJuLNS61j5LlqRaJ
         nBx8yScxpTpudUYxpzmuZSToxJmShCLq22zPU+2jwItJ+ULjzKFE+GZl3Vfp6ShfER8N
         xiuUwfRmL8vxEA2Tlc7fzR9qfqh1NdXIli72evfgaqfTAlAGy0Wc6u7oOUlDk7DxQEW1
         dGVPIdbPx6sMWKgqDN8+xwtWr30IO4Hz3WQY13iiX3xZa66DNZiqIFa5SF8Ok5L8lWqg
         9sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186553; x=1773791353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/oj221AyjL7p0LimTIXezs2T/jJm5OAuCv1irweo4I=;
        b=bIMsfzV4v7uFJiQYp7nM9NY6YVJPX0qqpHPEYOFkyHTn5NDVgL9nQAbiktSvxVFEBe
         aGjpiF0zUoT3D8jyGUq8pA6dP/z3m9gYbIl7QZWL+YeQUwLg/eW2EAuIZkDGB0tDAmtt
         rby8EEclTdc3DraU5euUc2rDxO/5iTgwv661Ye5ED1wwJUBxkvSKx0Eqc2LdCh09DLmc
         d6tAW4TQ5Dg3FXBoZJzWxrZFfpdyn4SKP/xWt+eeWgvBKSoz/+flMwX5V96vIsujTNnB
         UWA30T0bz0A5lzx3/vUXAPu16fO/GWgnQWw/6V8hkfTDlmpZi1LXNaW2ES51iXF1PbXr
         Ea6w==
X-Gm-Message-State: AOJu0YzCYIGXaNcrTGLPN0u5mbOxE5BNc9c7bO2YlyvF0rYXh9j//LLV
	jLCt4ZyBxA50gAcajOIROzO3EJBNxlHBoskfAvGJvrnP01uBUdyeo2J+EEglUexcNxpn+sNRnOR
	ZMUI8aA==
X-Received: from pfbef18.prod.google.com ([2002:a05:6a00:2c92:b0:81f:9d66:115b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1a:b0:81b:d5d9:a83a
 with SMTP id d2e1a72fcca58-829f7269925mr520796b3a.61.1773186553338; Tue, 10
 Mar 2026 16:49:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:29 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-22-seanjc@google.com>
Subject: [PATCH 21/21] KVM: SEV: Goto an existing error label if charging
 misc_cg for an ASID fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Dedup a small amount of cleanup code in SEV ASID allocation by reusing
an existing error label.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c35eb9e30993..32d7f329f92c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -289,14 +289,11 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 	if (min_asid > max_asid)
 		return -ENOTTY;
 
-	WARN_ON(sev->misc_cg);
+	WARN_ON_ONCE(sev->misc_cg);
 	sev->misc_cg = get_current_misc_cg();
 	ret = sev_misc_cg_try_charge(sev);
-	if (ret) {
-		put_misc_cg(sev->misc_cg);
-		sev->misc_cg = NULL;
-		return ret;
-	}
+	if (ret)
+		goto e_put_cg;
 
 	asid = sev_alloc_asid(min_asid, max_asid);
 	if (asid > max_asid) {
@@ -306,8 +303,10 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 
 	sev->asid = asid;
 	return 0;
+
 e_uncharge:
 	sev_misc_cg_uncharge(sev);
+e_put_cg:
 	put_misc_cg(sev->misc_cg);
 	sev->misc_cg = NULL;
 	return ret;
-- 
2.53.0.473.g4a7958ca14-goog

