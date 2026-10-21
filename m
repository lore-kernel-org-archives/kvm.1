Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550966;
	b=Uyh+lFDrlVEk/iX9kdtCW88pcUHJKdPzAuHBcmpvoUCSrfqBjubVUaQvEfetHV9VPoL4
	 8MiTesY1BxWhNJK5I4m8p0E/8X/k19EC2t5eAfPtr4JmYL2r4aZs5Tq6n7TIdlVCdVauR
	 Y9dh4OJpSElUIvmJKVWRxtXbooEjuaEXd+n+rNfc/9l/ACpC0gFfnAkYEh8DyBPYh7c/x
	 3fighMNXKPNqM7pcMa6cLZCO9Nd4jdDoBMnf10duEYKW2tWWCHv3cEaa8Bl0jn2Fq69Ks
	 KcapNOBN88THTzckCWqZ8ns+RHqxd7ohgVfRITUP2IVF9pJ9vkTTIZR/0dNUPw+/BPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
	b=Zv5HUefBJNFG/DtqC2J60UnMPKPKrAAxQbwSBeKbv5rOaByx6jaULaCt8/ecf39RvIOi
	 FB/5Jdnb7PDyWzXlS5yKs56y0U4anBmGG21X9fJQi9Rymb5l6byaWqonTHx+IRw4eBaTz
	 T2kgI86Jf64DntLdNvUHlY19FWHOxwifiX49X+nf6TzzOHuT+JHGZ1YqHbBkT5Mb1tVM7
	 7YYAqPTFvv0Frk70B5dYyTOtQBrt9L9GqvNLF2mpasIQ3ohrpEyL3pQ5XOIy7W18T339y
	 MLu9giPeAVDDpZxGCnJ13Od9i6ioRI3Nbc0CUW87fxWWFOPjKy0RsAoxf2dH0rh7LSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AVzps8aZ;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C165606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C165606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AVzps8aZ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac450b74b0so546541a91.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792550965; x=1793155765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
        b=AVzps8aZMOfSNEwYwjdNhFacax5Vdj/VHOahl4IygNsW61gBT8xQTISXu+5F6j8Dv9
         yFcHnokOKCNvA9JHNaSnT21oUxJUbcoPfgaMNAK/pRbqf9NU3Z+AmXJ3HPaNAr6DxPiZ
         Fy0Cl643FDTLOINdXaRELtwJKqeoRyXvdxi/ORDZlZrNQo4/Fhj5aJqkpdp9kL3WSCSA
         ofVeoYM8THlD3O+GFtOfHP/kZe7Z9cYlKzzUJe0LjFJfsoHaFiqcDX3x968OT40fjWzZ
         WsdP1SqRj7RQhtmTKlqmu7xl1Sa5Gb0r8wt2R8ejQE8LXCEl98DtkewNk7VP+JHEhxqo
         0SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550965; x=1793155765;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gSnH3fXxTz7HmVcM/xtbhh/4LxD2ZgAsSDglyoF9vfI=;
        b=akqqzAfsDefpTIHSJS8nMCv8OGEQA/eoDgWIQ2wXqgrl6QSsn69dcDo56FxSqSH074
         hhCc/j/1Flj1RzoG7JsZa1o1SHuELnZYu/tjalLbevc1un980RDc4T2dNczLzS7e9grx
         ZAOqikFpje8hRRVLRjVY+0fPIOuf4ySTJUb3zq8p7NP2t3xF+mKfTWDqqN8vz28ffjNP
         UPPNQWH+k7oyyu7nr0WfY7/MPLtmqQFJ/GyGcH23fIH3GjfTzhWyux4o02qfUhMPqYYK
         DH4GjkCGLPd0/rqmGY/feFjjl2tHTh9B7im7Hbd1fZtD7GPXvXq62FoYGE5v8Hcfm3RQ
         sISw==
X-Gm-Message-State: AFq9FYLxlSThFscb/fh1Hksz/cNikKuqpmQqs7QBXlROpg9bcfv1S2vS
	5l5rujiRKU02f64CyNpHnMIyhwfF/GewvrFuxvu/kT2ndMZoe50lhOQ7MVbk1lMsBPJokwprJrM
	0F8Ob5Q==
X-Received: from pjsa19.prod.google.com ([2002:a17:90a:be13:b0:3ab:9517:f413])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b90:b0:3ac:8527:3fc5
 with SMTP id 98e67ed59e1d1-3ad86afbde1mr745223a91.3.1792550964733; Tue, 20
 Oct 2026 19:49:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:49:21 -0700
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
Message-ID: <20261021024921.1735149-1-seanjc@google.com>
Subject: [PATCH 5.15.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
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
[sean: resolve minor conflict due to lack of lockless aging in 5.15]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 081547246801..a768cbe23808 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2336,7 +2336,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
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

base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
-- 
2.56.0.218.g1ec904b173-goog

