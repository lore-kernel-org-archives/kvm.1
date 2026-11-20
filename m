Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795208838;
	b=Fb9aj5ZCrm+mrVGazK1Zcv+g+r+58RjBQQr6JSCdnsesUNuHFgb4yoi/MlVj4QzH5F8i
	 5/pXLuDIdUK1YIYuE6R1Y3m5QimqWzKxwB7coL7FCfmPNaYKrqcAcKFmYAjELgS+aUwkD
	 uZrqikvohrSqxloxfrlXAXRUO1x88LXriyEITshruTA798UOgusApIHodsEAdPixjRGMS
	 NFp8ZVA+ALkmTkBflNMqVPnvt6ubsVBtbxeS8n+Fk0RKUWlofnXuZSj3AUWaHSJA5SOuB
	 cVuMI/nIJYSFDut2M7ExHrS5Mh21EjWm9wWTTV+GVxuQaHYBNLgKViSK4A4ZP+EIcLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208838;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AMh54TR0Yx74ZrJDPkxnOx/lYr8Z2aFztvrYWkfWUx4=;
	b=HNQqXP49BiU88hkcPyaGwHr6zsuvctrz/+zaTiPQPY/lH1ic1RNDffTq1ryihpUK9Pqg
	 SEaS0lEOjOc9t3xlR2IswvDg9VKXEzsPv0FskGq91/RwYjwKJjNjqjnj2oj+35nrYM9UN
	 GkJ+sk/CrM6j35FQllSPaiJL7gzdRuVvU0ze7LflVcThYd2uIy++sZN+Zlx5IS4BIyfWD
	 LM2XQON69zoJGKLW3vlOesqwdW7WeYk1ApttYTuG3c7yfJVkUXHjQa4IqokVpPRpevEUI
	 zPYlHNV4g0aFg+/e0ITjHlMwrpvRjdrqisP/USmsH/sIUIRfSDUo6iXh87cVMDEIG+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFCGdy7D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD560A2618;
	Fri, 20 Nov 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFCGdy7D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795208838;
	b=aF1+noMmSDu1eEMq9EgQt+NTUKZdXUpikM3XRycAj+jzmx49H90cXKl5ccq3CgShbD7w
	 iigXPdhs/wDPBNJIMFjtPM7+v3aIMVKekBnJszwDa3YZ0cacWyxxhXgB7WHRfotmmV8ze
	 yiqLWsf4+jfm056jh8s1DLXoqDXttJR6AwtIavAI1D3wenLo81kg2MqV3ecPmQaqFqIhQ
	 9WIXAtD9mf8ufAOIjEid57nFXbQVs0vLjxtmTL/i04hVpEsQBXkc9j9CCVCtTg2f+I+30
	 YBKt56jcVz5tzf2Glt/diU/Sz5cwSadAFp6Ax7rNIIKK95rxgTOAsnZPgqDiiRHVJ8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795208838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AMh54TR0Yx74ZrJDPkxnOx/lYr8Z2aFztvrYWkfWUx4=;
	b=q9eNIiEgBgiCwhEVQ/v7+/eLoATFNyZKFRzst7IoyZ1FTGlQrDIMR6rMDFRsLWS+Sl5P
	 2KFn2j32eRNm0EqjLl09AiNE2j8UojnNSonBhcnCDaexY9Zl+uJyb5UyJPN8PvR8CcytG
	 UoNGH1GrrxRmn14wP64iRqvx/EO50djsb/b/woymnD+UB4HPZvOGsdOT+aPoZ1ErTUwz4
	 dzbiea+dRo4DNOZlCYaCd8JE83lHHvtiIFUXnTvVA+/67ZCk3fqO/4nqJCSwu0KmWC4z/
	 EhYovxWtS8gvHN22dBXVkJA+1ObjYEx8BddsE7jGm4RcyBEo7v/05uwzbfiCOrtWKLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D3151F000CA;
	Fri, 20 Nov 2026 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208837;
	bh=AMh54TR0Yx74ZrJDPkxnOx/lYr8Z2aFztvrYWkfWUx4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=SFCGdy7DDgmsgow98a2HISw7cH+2OYk0QVUHjbHHGoC7WP/5+VUpCk/da7mkhVXaj
	 3BcqC0U5IqWtFtReGWtFHFoV3Le4MTWofxhjVN46HLC7rAFqre7ijGa0/mLLKV7H2u
	 NIRE5by29Eyhl16pHyEiPFMADYWbFEd2QMYnjSRy/ChCwonFjAAsxhwXPI7RpqGSF7
	 +WiXv3ouCHqOldgzf8TYIxqYf30wUbLu7vgRyYvdsPSe5lWxhftSihddkdt7fEcEjC
	 LXT6QT9p8wwS/KjQKieNizfuQpMlpXLNzTgQqy05wMGGoDpoKYxbCi68pz86Na+s6y
	 pLBEQ82GuFH1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C46064BA28;
	Fri, 20 Nov 2026 21:07:13 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 20 Nov 2026 13:07:12 -0800
Subject: [PATCH] KVM: x86/mmu: Prevent hugepage recovery on non-guest_memfd
 private GFNs
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-gmem-fix-gmem-max-mapping-level-v1-1-108788914fe8@google.com>
X-B4-Tracking: v=1; b=H4sIAH+2AGsC/yWNwQqDMBBEf0X23AUTaYX+SukhWbdxi0lDoiKI/
 95tPQzMg+HNDpWLcIV7s0PhVap8koK5NECjS4FRBmWwrb0ZY1sMkSO+ZDtLdJsmZ0kBJ155Qkf
 kfW+o664W1JIL6/r/8HieXBf/Zpp/WjiOLytk3UKDAAAA
X-Change-ID: 20261120-gmem-fix-gmem-max-mapping-level-accbb71c3352
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
 David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795208833; l=2547;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Y0i6Euk/xaC1ZCsSKIuwJUQwvKbcrEW4zjiLBGkW4HE=;
 b=yGonGreEgc0BdPMVqeglPV5HUwVFM4Dw1iv2Lr9P4AMWQ6f6wM0eyzt/GT2B9ke6JNrIpdkAm
 uf9Z/wXEoTuBqibEvSAT8CtdDu+DCZhw5/hWtY5LzPjcfz/kBPIaVu4
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When determining the maximum mapping level outside of a page fault
(such as when disabling dirty logging), KVM queries the VM memory
attributes to determine whether a GFN is private. Userspace can mark a
GFN as private in the VM attributes even when the covering memslot is
not backed by guest_memfd.

Previously, this caused the mapping level calculation to fall into
kvm_gmem_max_mapping_level(), triggering a kernel warning.

Here's 1 way to trigger the warning on a TDX VM, with VM memory attributes
enabled on KVM.

1. Create a non-guest_memfd memslot covering a 1G-aligned base GFN with
   dirty logging enabled.
2. In that memslot, fault a shared page outside the first 2M chunk so a
   non-leaf PTE at the 1G level is installed.
3. Mark the first 2M chunk (at the 1G-aligned base GFN) private. Conversion
   zaps that 2M chunk, while the shared mapping outside it keeps the 1G
   non-leaf PTE present.
4. Disable dirty logging on the memslot.

Hugepage recovery iterates over the present 1G non-leaf PTE, sees that its
base GFN is private and the 2M range is not mixed, and calls into
kvm_gmem_max_mapping_level() without a fault context, hitting the WARN.

Return 4K as the maximum mapping level when a GFN is marked private in
a non-fault path for a memslot without guest_memfd. Fault paths already
disallow mapping private GFNs in non-guest_memfd memslots, and
returning 4K prevents hugepage recovery on such GFNs.

Fixes: a3522ac71f5e ("KVM: x86/mmu: Enforce guest_memfd's max order when recovering hugepages")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f89e9f8a6cc2f..af40fbe9001a7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3489,6 +3489,14 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 	} else {
 		max_level = PG_LEVEL_NUM;
 		is_private = kvm_is_private_gfn(kvm, gfn);
+
+		/*
+		 * is_private (set in VM attributes) should never have been used
+		 * with a non-guest_memfd memslot. Return PG_LEVEL_4K to prevent
+		 * hugepage recovery.
+		 */
+		if (is_private && !kvm_slot_has_gmem(slot))
+			return PG_LEVEL_4K;
 	}
 
 	max_level = min(max_level, max_huge_page_level);

---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
change-id: 20261120-gmem-fix-gmem-max-mapping-level-accbb71c3352

Best regards,
--  
Ackerley Tng <ackerleytng@google.com>


