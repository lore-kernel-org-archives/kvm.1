Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF95282F26
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110408; cv=none; b=bPQBPjlVh3UwDgq7foYcvuOXYV6BOoOpcuAi2eDqQCrncSwaqnfGWjtsYY3tELfwM+g7gT+3eNrTcSxKqVKZgbyNmmKUfsYw+MrA1ml/o4FkZAFMzmP+G35xJqYuEO7n54gJeOqZ0XwveO2mXU8dqwPLGtGLPx+NV6v91Nfms/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110408; c=relaxed/simple;
	bh=8ZCbd1r0p1hFVRN42Nrj31bGv4uQWdavK7XAJwkweJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4KTrOTZ9/TfMMIYENVb/HdkDc4uoIBE15zy5MCDrhCyeyYnn/+dzyC9KJCxExl0clqAtDQogveMcMq8f7Jj5OXQLMK3Z6vPOj7DOOVJwFqTmA23L0Ftw4vpuCcDIYUg0EW7Urh9X8iEYvlIJhAOMIZWSroIL3kIGviA2HdHrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLWbw0cL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+UNdQf0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLWbw0cL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+UNdQf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786110400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
	b=fLWbw0cLUmchsWntoDmGVZssaquDLrMMvGBYDjrda2Kj5OvhoWeBesjGDpvToS5WoM6Zw3
	76RBjUVh5Hjyao8jblF99HTA9CO/QIFoQqjJetq5EQHAaS23C0iMHN9hg7XGQp/yLfO2mZ
	EO0txVmjE+AZenKe/VPK8rE1ibCDqRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-zB09c8YlNZ2tWoamAAU9Gw-1; Fri, 07 Aug 2026 09:46:37 -0400
X-MC-Unique: zB09c8YlNZ2tWoamAAU9Gw-1
X-Mimecast-MFC-AGG-ID: zB09c8YlNZ2tWoamAAU9Gw_1786110397
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47faa02f707so1720654f8f.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786110396; x=1786715196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
        b=D+UNdQf0mvpMwUgs1vqS2AlbkeO5rnbvV3DEByzYgApIpWNGu3faXsEpCHIsjAm0gK
         Ul0Pk3pfYcKaUgEX5YMNsdv2oFCXKFrWxwmlXtCOfLiewdPjQnmbpLrEjAMcSFdgG2om
         Tf3uW2xVQPUP4Km/vhdstLgRAGDN4glXj26LwjI9KYE2ZGbZkjpUXArOEGkyeIEih6Be
         ItaJw7Kb5qpfxBUKaJBXKUCjpm8ItC1Xz6rNfDha2JQE9OFRS5duqbV3eM1TJ7ggYTbr
         BuQihWOry+HZsx77ErZESfHn+yF+0GACE4yx9F/cMfs3cYYCjDEGXzduXAbcpbBUJfY7
         DaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110396; x=1786715196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryyH3WMM5bXwtJyWfdY/n49oHZTrsfyGZBILZcJ/9Sk=;
        b=VusnSgUw78SnNflWs7NESas/El3iGiQQxCJDwxrONSyP1vrLp0njE0rLxlfZRcI88t
         rQjphQgWvT8JpefKUELjz8/bIthCxtPVWIY+RTClNNvU9hnrsaIuWTIWqXNdaEGqPGK7
         JvO8LCXKgSATMxrze7gg/Md4/yKBp2glsLerKdZXj7LG0k2LjhuLajbFTVoHpYflHjMp
         xq4jFBc13ZwJ2EtNEPPEGZCxdzSUigfb4kf4NPxG9pr/FXpVfNA1t9pkxDTaIJvh5gWt
         +pAkBwb18MSxHdEX9XlK/b1D3H2kz4m5diDRw3At1QnsZVkX0UEPRzJ+HO3wnpXAkdyp
         JsAA==
X-Forwarded-Encrypted: i=1; AHgh+RrSiu7n4KyYJtE+FZsWWlT8ee3e0AZiqB7/Ddx/FeHvLGHLgigpF6CkHgi8dm5wBByi18g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ebny+O7/QeiR0YVQGoZtkYGI6yFkdWm++LcJVd0ylpfc86SG
	rsbd3RbiRQUpw7UBoRqVUgRWvnvnrkv5lLll2fqzLU4D6UzgcikCItBjdexR2hfCKibS2rS5i9T
	0TXBguo6tReyNNnnFoUapvU8BeOD8Y701ghj2c0tVzwvQjT4YMQ8vYA==
X-Gm-Gg: AR+sD12+l6NbcrYs8xZW26FFLVtNUFGKAp5pn93jOoN4M1L3wec/Ysd6PqdgK2SANmu
	hqoZfgQigKQ+PR2j3VujBH53F//aL6+C3kNCaUt+k0MtVWjbF9NPWtrlxiXO4ji9ac/hMzDfiGX
	JIP5vkkQ7StahL87h+xYdFSIJeHR46BqeoMMh9mcWMVBqicpUUOHIXEbBMRrHww+wBYUVVzwxRq
	MoqupuxYJJyzsBjy40RB1YnAYYyP0xTiJBJUCkHNVVwy4VyymkZ8etrdH97FCT1nEKFFR/K5o8+
	cyE9RuWdbnaW0nswCVAx0IAkv7G2mRfxv9A0v3nVIGN671YYnNDP2LnXo6yzm4fGnHH5LqMTXwf
	6N3k4HtzBQKNsBTqJMyWrbRqwaUCUKSd+YVxkyIRwWqoID9qr/9aQ7VHGA5dA3AeYpbfPrYk/Sr
	pMWgc=
X-Received: by 2002:a05:6000:4204:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-48130b2ccfdmr187614f8f.11.1786110396468;
        Fri, 07 Aug 2026 06:46:36 -0700 (PDT)
X-Received: by 2002:a05:6000:4204:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-48130b2ccfdmr187464f8f.11.1786110395790;
        Fri, 07 Aug 2026 06:46:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fd392sm5928108f8f.31.2026.08.07.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:46:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page
Date: Fri,  7 Aug 2026 15:46:33 +0200
Message-ID: <20260807134633.2622273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Explicitly clear role.invalid when deriving a child shadow page's role from
its parent to harden against bugs elsewhere in KVM, as violating KVM's
invariant that invalid pages are NOT on the list of active MMU pages leads
to use-after-free due to __kvm_mmu_prepare_zap_page() using list_add()
instead of list_move() when processing an invalid shadow page, i.e. makes a
bad situation far worse.

Yell loudly if the parent is invalid, as it means KVM has missed a validity
check, i.e. KVM is attempting to map memory using an invalid/obsolete root,
but continue on as the child is otherwise still a valid shadow page.

  ==================================================================
  BUG: KASAN: slab-use-after-free in __kvm_mmu_get_shadow_page+0x1817/0x1860 [kvm]
  Write of size 8 at addr ff11000153dd1368 by task repro/853

  CPU: 1 UID: 1000 PID: 853 Comm: repro Not tainted 7.2.0-rc2-3aec122bdcaf-next-vm #5 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4b/0x70
   print_report+0x153/0x49c
   kasan_report+0xbc/0xf0
   __kvm_mmu_get_shadow_page+0x1817/0x1860 [kvm]
   mmu_alloc_root+0x141/0x320 [kvm]
   kvm_mmu_load+0x612/0x20f0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x3dd5/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

  Allocated by task 853:
   kasan_save_stack+0x20/0x40
   kasan_save_track+0x14/0x30
   __kasan_slab_alloc+0x5f/0x70
   kmem_cache_alloc_noprof+0xfe/0x2e0
   __kvm_mmu_topup_memory_cache+0x135/0x530 [kvm]
   paging64_page_fault+0x318/0x1e30 [kvm]
   kvm_mmu_do_page_fault+0x21d/0x630 [kvm]
   kvm_mmu_page_fault+0x18c/0x17b0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x1f35/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Freed by task 853:
   kasan_save_stack+0x20/0x40
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kmem_cache_free+0xe2/0x400
   kvm_mmu_commit_zap_page.part.0+0x1e2/0x310 [kvm]
   kvm_mmu_free_roots+0x283/0x560 [kvm]
   kvm_arch_vcpu_ioctl_run+0x33c8/0x6150 [kvm]
   kvm_vcpu_ioctl+0x5e4/0x10d0 [kvm]
   __x64_sys_ioctl+0x131/0x1b0
   do_syscall_64+0x67/0x5f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: a770f6f28b1a ("KVM: MMU: Inherit a shadow page's guest level count from vcpu setup")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c9e4739b26d7..a61750f8e1e3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2442,6 +2442,9 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
 	role.direct = direct;
 	role.passthrough = 0;
 
+	WARN_ON_ONCE(role.invalid);
+	role.invalid = 0;
+
 	/*
 	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
 	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
-- 
2.55.0

