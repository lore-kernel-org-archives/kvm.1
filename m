Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550842;
	b=rEQ76Y68dLCXIalHyuTNacFugRyu+B+54aNIrrjflcT8UX9HUpHIj1BT1S0337aD7Co/
	 iA9nnyiGsF/mpk+M/MCFyCfocScumNUA3ZWlo2+qc9YB8aGfbCnFjBG5tQK8vIMWs9y3i
	 G2GsNeqKqN+kUfFemyco9hM+j++1gMOqY9twZmR8reyTzzelWLURsBBb0Kkavkk/XsDYZ
	 1WajxRH1Du0y0pS/Dl5vgol+v/5T1NlkXj0gq2efuYo0WlHnaUEt3zVD2NT1yEJTZ51Da
	 LRQpNL3pkXwu+yf/HuJaNeZQmpl6pbKhSJ9uhzXzRes8PkaWfxLCJ/eX2hlXZOWPkqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
	b=MU3qzkTLpPmCtdRoZ32PuYceJiKgPs+r8X26jldSPq9i1/OHg2aGInNr3+EWMh2qdyh8
	 nUPtgdSMLuOqGCPkPEuUuSIpw2BLoaScxZhoiKxqYA1tDZl7lghtb7zlQAI6ySQVobKWi
	 QfDTO60UWsdNNhi1Oxapr8nAz+An9QWX5fb6Yyg56U2TpjWygn3HANVkOmca85T/F2VI+
	 rdZYViqxw2VWkWtqqIDXQZGO8F9n2jZdE/IVpilaIzS8f/PqYDB3uMZ54S5ztBNzebPqh
	 RGyWRTCMKOmGc9taZAaZF65tDnaxQ9x9jTBD+4TFCYtHqj+m8V77kTcOnp3vCh9oJdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=slSeybQ5;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF8606A31C
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05FF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=slSeybQ5
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd6788d8de3so114210a12.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792550841; x=1793155641; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
        b=slSeybQ5VO0775Rm1nSjV9bSrBlF4TBwpbGXqUC+BkLuYPJSuJMRzFslPw+CL5uZ+A
         rcCkvUTn7vOx6mEQknbut1vsIqdGZh6gMzl44WuTaQzQytXYA+x4qKe1J04Q0H5II1Dv
         fSOSf3YR036+DMl1SjK4J4ZrNG4mDnRhOEeLJzjKASYoOOUi5Fspa/B5JtFyYcTJWJNq
         ws0X1+tPVTijwVV+tJ+wL49tjRtgwQ45PK3tn9N2SgArSiHk/dS9jXaXsbG72gEAqEGa
         BehbCfmLgJIeHPhgL/rsOuCDVPN8Cw6KOhjx/FaBm3WjXDzVntLPp+4GF9+1lScAOf2i
         9CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550841; x=1793155641;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2C93UiKAOXUB3tOivza+YaCz61WEDjXX0iSv8bO91c8=;
        b=huP1/3T6PCuJU35uUIcTtbtSvETOtjWvGNj0pALNd6C5tFyxoAZ4BMInck+QJssagW
         n08v1ccJWW0wUKhHYPidpNVxbJUj981KItcHckMnqvP7kR3F9mJqxujytRWI2jeCo9jg
         gTfHuYRZwRMnHCwQ1T254u6iezG0ICixFBg61h7LLwcix0gi0frKsx1u0kZkjX2l/5P7
         AOMptJarQZr4XChvcOAOQMwWkkZPG0nLqDmQDnPMI125QWhdSXCs4MmHR2emqE78/pyq
         DDk9g4oAEwl/W4SaQIynqi+3V3zYEzFf9EnThVC0E3dOA5pyI3mLV395eifn7L1460iV
         8BQg==
X-Gm-Message-State: AFq9FYKTfD140rIohUO0vuSNfBQscDrECwcl4gcfFf35iVFI39Wi5UGS
	sUX5ubUNLL9hz6tV2i2F0PMQ00RmoanQyknuFGA9/JJghBEEnhMaFk7+Xyue5mCUkj0NhuKElWV
	yRCqyCg==
X-Received: from pglf14.prod.google.com ([2002:a63:100e:0:b0:ccf:d903:c14c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a21:b0:3d1:c99f:efbf
 with SMTP id adf61e73a8af0-3e287d241d4mr655872637.14.1792550841217; Tue, 20
 Oct 2026 19:47:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:47:17 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021024717.1734016-1-seanjc@google.com>
Subject: [PATCH 6.1.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if
 they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
is non-zero from top-level reclaim, because such a page cannot be
freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
nested TDP child has no such check. As a result, a shadow page can
be zapped even if the page itself can't be freed; as the comment in
kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
to rebuild the page.

As in top-level reclaim, do not recursively prepare zapping of a
nested TDP child whose root_count is non-zero.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: resolve minor conflict due to lack of lockless aging in 6.1]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d7f1fbf8a83d..33e89555bb09 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2395,7 +2395,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}

base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
-- 
2.56.0.218.g1ec904b173-goog

