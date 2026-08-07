Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD473F6613
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102113; cv=none; b=hyrmRDXl1cI+upxv4lllVJUVlxYiU8l1wPlSMAIPmoeY8rqOaRmpmd1PDx5XRDFM7OoJN0LjbEz09iDe/t3eZUUbZZzHSaTBuGU3QTvh2JLzMWmdqPwiYLPb7nXemUuetjgPTi9vhufAENyccjQ5EoFEWiP8J/ivH0TEU+ZiXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102113; c=relaxed/simple;
	bh=0NJWneQd42p6nsM4SM7jMo3B5ik/+16voeu3Ae1XL7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaucRRxloU9toPcEj3leAXbYrBigGtaKvIo4yr1MjHHz7C/dEJMbPTtA6TD6ARhiKy21nI2wfXYJ/0iujHYft35HbbvqfyjgzPm8gXUzlebLBivfnH1kMz/xAoAaFo4ufYd31hk3OLwM/eZOhbrTB3v9udBxWRmCsZsGcuRBcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmTZDrLF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmTZDrLF"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso3660693a91.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786102112; x=1786706912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aow9O0foreCcH8dLlpP0RY6tpW9mpLoBDPH+sNTMhIs=;
        b=JmTZDrLFCy/WU5O9lUQdlfoyOj16L4qZ22zvw2OwnQA3dtOFnyDGg0aGv0R8suJq7r
         9cEyvtX/uavULJqz3OOh66L7kb9TjNWWVrE6gBnhtJy7HF52zNQ3pD0zzpVegL9LDoqa
         FyOWER9zbEXelIiCERrG7lj9CEuwK3tIf1bmGylbc7tuzgf8X8Nc9NNc9kKJMEyIBuCO
         zy/jQjvy9GPdGqbM2/+HvGzvbS/7TmblIw91sdTmvGPcTxBZy8hGREdBzbr70Hf2Afma
         V703atdQmcbIMAmuFKSXMHxrR+GOjkTkLD8nqOuFVn2sDG+wAXRPZOxHw6la17ETuTfq
         mnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102112; x=1786706912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aow9O0foreCcH8dLlpP0RY6tpW9mpLoBDPH+sNTMhIs=;
        b=lhjSF4RBsSQC2bI9YImY8qh1Wu2Q4HkxeLl1mML7/qK9//hJrHn2UAGLCPphJl10Og
         aEHN0bcopHEQEjkm58jlB8mtnSdQLRQ0QYJveJ9geCY3S6QWAR5bH1pl4W+mLdH4ImM6
         VjmQHJ4V5hK8bZFseynYy38NMggo8tkZPvY4uazhQcbbv9FovqfbKuPdk0TDH2P4Khm3
         WKLjUElkAN+OmQxYQlu0lP45WhkM17Yi86patEKo+o0CZgwFpxvEVrKP44Ku2ZVCfJAR
         +wIXPeHpWZw6fLfXvLZEiNjhDohe8PK+LPgITq2uc1kYs8VO/WLe+1u2e9iU5B/s1u7p
         LDXQ==
X-Gm-Message-State: AOJu0YzeePXyieKbeLCZG1qqRS24L4vufQDFcby7F8f9aiBvDYR09mbW
	qIlw/Ngn4oxLTcEOtejkCqoql4kncMpd4ZnXDHZ0ZJC3m+SM/DJNNK3y9GgAb0V1Exq4dH3C
X-Gm-Gg: AR+sD10Qam2JfWBn1vFZzq2Wb5lsKZ4IGGSSN49u4kOAJV3KAkPRcvMT/TpI7CxKW0+
	8g5j6n+oNbYlgf/U2OjguUf0qgrsaOFDAgEtD03wu7QU8O4A0a/nyrdqcQ00l9EYdcI6+m1oHJB
	+AHLDpjJK2GM9tp0aVjbcR8nt1ZpK0AvsSqTAxw204nyTT8qlev5IEGxON6YvaNLodlrmCTBTyg
	tTa7rlJY1KQM+2DGwtZ+g3xVGHutF27Dr3OcRJ6C9i8130E3EH1T0j+Atu7WQvOAaUgRV9q1rMW
	UJ92fMNWIDLY82Nf2S9CAyHEEb5aD5AfU+wLobUOohmUwOJEe/Q59f1NODSKnBjTc9uBtqzRmjh
	sbraQ30u9JS2l4YulRgWQB34pEG1ZeVIri/wZKpG6MrCc9xUGSRCQmksw50oh9/B1X0ZBTC3344
	kbAyr961BifOgAjaVdqpD2ReJ924D51I9nZK6JKFCJ54WTVXt4k+FkhcfdhTvP6LRo0IQqfLtWl
	m0QkmehojqPCIgDKdMWQ0ehcwsiTx0=
X-Received: by 2002:a17:90a:dfcf:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-3903c5589ecmr23642281a91.7.1786102111804;
        Fri, 07 Aug 2026 04:28:31 -0700 (PDT)
Received: from DESKTOP-58PM2JF.lv.net (ip-64-250-227-20.isp.net. [64.250.227.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7ad29sm6085396c88.13.2026.08.07.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:28:31 -0700 (PDT)
From: Jinu Kim <kimjw04271234@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
Date: Fri,  7 Aug 2026 20:28:18 +0900
Message-ID: <20260807112818.958190-1-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM tags the per-vCPU MMIO cache with a memslot generation so that a
memslot update invalidates cached MMIO information.  Both the fill and
validation paths use kvm_memslots(), which unconditionally selects address
space 0, even when the vCPU is running in SMM and using address space 1.

Commit 56f17dd3fbc4 ("kvm: x86: fix stale mmio cache bug") added the
memslot generation to the cache key so that a memslot update could not
leave a stale entry valid.  When commit 699023e23965 ("KVM: x86: add SMM
to the MMU role, support SMRAM address space") added the SMM address space,
these helpers were not converted to use the active memslots.

Consequently, an update to the SMM memslots can leave an entry from the old
SMM address space apparently valid after the vCPU returns to the normal
address space.  A guest can then cause an access to valid RAM at the same
GFN to be returned to userspace as KVM_EXIT_MMIO.

Completing that exit through the VMM's RAM address space writes the backing
page without going through KVM's write-tracking path.  If the page backs a
nested EPT table, KVM can continue using shadow translations derived from
the old contents.  The WARN_ON_ONCE() in kvm_mmu_write_protect_fault()
catches this invalid cache and memslot combination.

Use the vCPU's active memslots when caching and validating the entry.
Memslot generations are unique across address spaces, so the generation
also distinguishes the normal and SMM views.  This matches the MMIO SPTE
cache, which already uses kvm_vcpu_memslots().

On an unpatched current-mainline kernel, a regression test that fills the
cache in SMM and updates only the SMM memslots fails the intended RAM write
and triggers the kvm_mmu_write_protect_fault() warning.  With this change,
the same test completes the RAM write without a warning.  The x86/smm_test,
set_memory_region_test, and memslot_modification_stress_test selftests also
pass.

Fixes: 699023e23965 ("KVM: x86: add SMM to the MMU role, support SMRAM address space")
Cc: stable@vger.kernel.org
Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
---
 arch/x86/kvm/x86.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de577ef9c97..a6d86d3dcff6 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -313,7 +313,7 @@ static inline bool is_noncanonical_invlpg_address(u64 la, struct kvm_vcpu *vcpu)
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
-	u64 gen = kvm_memslots(vcpu->kvm)->generation;
+	u64 gen = kvm_vcpu_memslots(vcpu)->generation;
 
 	if (unlikely(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS))
 		return;
@@ -330,7 +330,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.mmio_gen == kvm_memslots(vcpu->kvm)->generation;
+	return vcpu->arch.mmio_gen == kvm_vcpu_memslots(vcpu)->generation;
 }
 
 /*
-- 
2.43.0

