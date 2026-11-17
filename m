Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794952560;
	b=gwHsAOVy2N2CH2SJblnAHU/aDyiAbocBO2sWMehaUgmfb3BNIeeK1+dc6JH7G5nptWb0
	 aYtbbJq7MsQXsPKcJH+tKuL3pYms9c0sQow5A3qIOy2wL8BaB17Hit3RXD37bA09pvMTM
	 9d8ZEPKf8XKFOlCu/rVHAzQfModK0bs7nhaXUdOvhlJ7a65ScF+Qi+jnW1ws3Md6PF2GX
	 19p9NAWllSAFNdWmJef0oMPki/JjLn93Zhx39HXNCrunxvbZakxbwMP8/vACF2V75VesZ
	 wsPWd3+JAiIfQqM5RZReCNDT7nqs6YYMzn5PoCNvX4gIgMWWYtnB72ybMBqW5qnQVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2JQa7rqZUcilixNgol3luV0Hy2c7F5fvWLd3A2v5vDc=;
	b=4kS0Vx50vaLkIVX57xgcVzssy0QEgi3g5USAyojwAgaqBPcvWBfXOk4jeW7g7QrtB7u0
	 6joo0KftMIvTaE+nxeci/MDPqXRkFHK9qVBVGZ+l2lrv2Ss+tyPA4pz/b5sqVU85aKuTF
	 FhHH2Z0LwtfxrUkQ9QhP+cIF2oYrqjX/ltvggbw6vew7eT9djmJthbVZEn2KmyNfVM6FE
	 IDoEqZMRWPT7j+rUMvVzGwBtLF9rlbi73hAmzDMiJMZMhmseS2XDrCh0e+weonD7a+pxl
	 0sZZyUYweoTbH7JdE1Mlroz39NmKEty7jijzWdK7k1Rq8nbGd98yn6JTaLqxbJ2Sa2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MleasB1n;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB90606A882
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB90606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MleasB1n
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3b74351a4so190384a91.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794952558; x=1795557358; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JQa7rqZUcilixNgol3luV0Hy2c7F5fvWLd3A2v5vDc=;
        b=MleasB1nhSZu5/7tyVSGvLwR8MZ21gU+xIADPjz3kF2HlxQFT6xQoXQutIvolsWASn
         BE5MQI4U95Cj6lNzZX382EW+mqOnCvVljFvujx0aDTuLNkCUlpYamIKgj2Pt/LTwhSp+
         Z1ggS8Bo+3GWXT1SUSh5rVuSXoHc6xTQk6HV0CtHD97G9zVOgd84C4T+3ggkI/+zYvx1
         zzP4kWsnvHdgIrk5dpz3o5+BmYZdUvJYl/LBr8/pAcMGgk1oGsOvSqmPJYMSvq4t8esj
         6QhoUbN5JcgDMkHULeNsvnpd749GOcmNRFKINTYj0u9u4PBwl3kxV6rGd9sbLM9us3tA
         AXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952558; x=1795557358;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JQa7rqZUcilixNgol3luV0Hy2c7F5fvWLd3A2v5vDc=;
        b=uA0HDY4SNIz83q3xF7ivWdf8wJoRVOmAM1POlGhML1DgsUIt2x4xu7EVkXlnN5NOyo
         XjEQBNEYaP7eefqVTVKkhPuUngpVlVuucx4qIAN0wWZv2z8cOGr6+1oUl/wnLE3a2vVS
         6dP+Yvjv3+u8h0xE/hm6SMqS0AcvbSOXWMpU/Rx/lPz8o+6lg18XAd6Gv3PHLQNIQK33
         2qIuyGqYVl9NCi3jZzK4O5rll+/8EBY7QKWjzIC8ImYnd4Wti/r+PJoyaay2VUoQgJ7N
         6ksTF0V4Iw00u9DkyouEzPf7W8ywEg4HguDo04MiYbjByuuQm9wwevdSYohVKr/k8kQt
         PsqA==
X-Forwarded-Encrypted: i=1; AL+hErF9t72kaccCE4xNB11maTsnppinIYNjKeB91NVj091a3s9tQMYpSv1u51d8ds+xbWs/aIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k+3OLcCR9f0Md+7FZEVuaS0s8zL+J4p59hx4GgzIBrdO0golq
	tgtL3WczMqqVT/bodinrgOVzAp57U8HlXSYqkiOnOBBk+1iFJBgsEeVnOQETLNfxr/+p164KGKh
	zFxk+DqM0JUNv4pZgGWi3Yw==
X-Received: from pglk22-n2.prod.google.com ([2002:a05:6a02:6b96:20b0:cc7:b263:342e])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2642:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3b3d0765fffmr663064a91.36.1794952557723;
 Tue, 17 Nov 2026 13:55:57 -0800 (PST)
Date: Tue, 17 Nov 2026 21:55:57 +0000
In-Reply-To: <sashiko-outbox-219706@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <sashiko-outbox-219706@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117215557.3756787-1-jthoughton@google.com>
Subject: Re: [PATCH 4/4] KVM: selftests: Verify KVM doesn't reset unused dirty
 ring entries
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, sashiko-bot@kernel.org
Cc: jthoughton@google.com, kvm@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On 17 November 2026, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Should dirty_ring_reset_unused_entries() clear flags back to 0 on
> dirty_gfns[0] and dirty_gfns[1] after kvm_vm_reset_dirty_ring() returns?
>
> When kvm_dirty_ring_used(ring) is 0, kvm_dirty_ring_reset() breaks out of
> its loop before calling kvm_dirty_gfn_set_invalid(entry), leaving both
> entries with KVM_DIRTY_GFN_F_RESET set when vcpu_worker starts.  In
> kvm_dirty_ring_push(), KVM increments ring->dirty_index before overwriting
> entry->flags with KVM_DIRTY_GFN_F_DIRTY:

[...]

> If the host reaping loop runs while the vCPU is pushing its first two dirty
> ring entries (for example when reap_i is 0), kvm_dirty_ring_reset() can
> observe the stale KVM_DIRTY_GFN_F_RESET flag together with the incremented
> ring->dirty_index and reset an entry that userspace never collected:

Yeah, this is possible. Sashiko's suggestion is the right one, I think.

Sean/Paolo, if nothing else in the series needs a v2, would you mind squashing
in the below when applying? Otherwise I'll fold it into v2.

Thanks!

---
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 96a4048..b03ce06 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -381,13 +381,20 @@ static void dirty_ring_reset_unused_entries(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Mark unused entries as harvested, and verify KVM doesn't reset any
-	 * entries, as KVM hasn't pushed anything to the ring. KVM will
-	 * overwrite the flags when it pushes to the entries.
+	 * entries, as KVM hasn't pushed anything to the ring.
 	 */
 	dirty_gfn_set_collected(&dirty_gfns[0]);
 	dirty_gfn_set_collected(&dirty_gfns[1]);
 
 	TEST_ASSERT_EQ(kvm_vm_reset_dirty_ring(vcpu->vm), 0);
+
+	/*
+	 * Clear the bogus RESET flags, otherwise a reset that runs while KVM
+	 * is pushing to the entries could reset them before userspace has
+	 * collected them.
+	 */
+	dirty_gfns[0].flags = 0;
+	dirty_gfns[1].flags = 0;
 }
 
 static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu)
