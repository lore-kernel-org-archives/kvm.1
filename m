Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792532D7F1
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869081; cv=none; b=uc5+xgcce9sMAeHLRZdO4gKwPF8w0ta0EGeaOoJ3JHDONAjS7bjeu2g7Pf0hOOosuYx/zfLqTz5JmCh4snm8bq/mMzgAcnRkCnUQ5UuHWPrKme8jD21rPNZosRkQ/W4ITYs6UDpShQqY9MwjpMVPNK+64lUhGDNBACHs3nN4+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869081; c=relaxed/simple;
	bh=4g6D4WJqie44pY6zCy76n2BzsOIVEEIrPZSj7mF5FAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoeaE9E/Ezq4izrwhv+Sdlbee5UOgDDtvQ1vfcaxKAjXNamsH1yh90cJJz5OmvUpyafaE8nIG5QiWym2OBcS/TSwU1WNikFYbTTlbjHqtIFhRV4GobVo4yZNCO/1w9U/NZiR0MzkK0U6QDxk+SZdCvISQisov4FCXpH3ShwN76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sG77tMg9; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sG77tMg9"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso214269a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787869079; x=1788473879; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cw6ij3wxYDl68tkuGy7ynKowVPqKz0JRX8l/MVMdLYQ=;
        b=sG77tMg9BWSVggMVjf/M6HFrcfVO/fq0MD7sHagaWCvBl6juIkrqw/65YaJHHnV6yC
         jxTLYmxHqnrtK0S2viqh6Tx79eMSxzqnqjcwrzjmeV7dCJmFxty3QsVqyBvVqwQYnJSP
         ukB1dOptEFv34aJiVO0B1KtWX4aJo8XWHZz60EIIr0VHxRDSN6z5EFkWWxIiiM9hELbK
         x4PO0Ny9cmC5BKOiMu8Hj3HVpFQNDhHlJGqNkh7h1xtOUeTBHhBAYOx+40v/mwkdCtg7
         8USAeSRB1vTpJuzmTM9oQE1Op5F+rl/wlRIQLdzK97w1WhNpPiL3D833B431Pyu7S89/
         NOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869079; x=1788473879;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw6ij3wxYDl68tkuGy7ynKowVPqKz0JRX8l/MVMdLYQ=;
        b=KC6FZs4uCyaxBHcmar6g2nS0KahdK84+OWXwuWjKuPQKmJ1dfVZpNGEC6KYKHW7b/T
         SgElRPrv17ErlVKfqxqBqUT6/iSRjJfmCwJSBt6LXsz3W/W1zSPhED2qqFqYICW2TW3K
         PMtpqyoecEtj0lcYOaa+6q9uYRLfNnvew9jrJ0ZFUQYzgkE9Cn0jdjqWAjR8elqXXOuB
         3KgElAAWypEuRx342JZwZDrSDD202ZAg+foCISXcI7a9T5LVRlacDXWiNkTmuPSeJkEz
         idSZOnxQRPQM4h2I96g6DXhhWCCBBKene1E/edICQyOe3gn7Um8U4fsT0+1KsQeGgnfR
         8BOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHm1Xy1E1PwmqkyW/ZC2fuYWn3u1QQhZorlnZIHVsjiXisUjm8rpMFODNp+gOHKHDhMRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mQfvr2vJOquS6bgVkXqsJ93UB3VVyX3kc76a5kOcZ0HbxvoTxE
	HflFLUiAW0k+b7jV+tDW6joJ64tCMHWv+Vu69Vw5lgVQl0ny3Cdk8EWWEdyRklcOaaQ2/OZ31Nf
	awZXMug==
X-Received: from pghf20.prod.google.com ([2002:a63:e314:0:b0:cc1:c65d:a775])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c8a:b0:851:8394:1696
 with SMTP id d2e1a72fcca58-8562b49995emr4859459b3a.12.1787869078698; Thu, 27
 Aug 2026 15:17:58 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:17:57 -0700
In-Reply-To: <apCwV7xenDh2qmr7@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8d47b43e1829ac92703723e6a1a4afc7a2eaacb5.camel@infradead.org> <apCwV7xenDh2qmr7@google.com>
Message-ID: <apC3lYri5r4KUM3T@google.com>
Subject: Re: KVM: x86/mmu: __kvm_rmap_lock() preemption assert trips on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 81c30e2c74f3..31a372d0697c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -913,11 +913,15 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu
>   */
>  #define KVM_RMAP_LOCKED	BIT(1)
>  
> -static unsigned long __kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> +static unsigned long __kvm_rmap_lock(struct kvm *kvm,
> +				     struct kvm_rmap_head *rmap_head)
>  {
>  	unsigned long old_val, new_val;
>  
> -	lockdep_assert_preemption_disabled();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lockdep_assert_preemption_disabled();
> +	else
> +		lockdep_assert_held(&kvm->mmu_lock);

...

> @@ -1745,11 +1754,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
>  	gfn_t gfn;
>  	int level;
>  
> +#ifdef CONFIG_PREEMPT_RT
> +	guard(read_lock)(&kvm->mmu_lock);
> +#endif

And now I remember why I swept this under the rug.  This really should take
mmu_lock for write, otherwise concurrent aging threads could theoretically get
stuck competing for KVM_RMAP_LOCKED.  Which is silly, because they don't actually
need to take a lock of any kind.  I.e. it's not super trivial?

Wait, duh.  It is trivial if mmu_lock is held, because then KVM can operate on
rmaps without any KVM_RMAP_LOCKED shenanigans.  I wouldn't test this because it
might break horribly, but I think this?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 81c30e2c74f3..2b157b390a40 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -895,6 +895,7 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu
  */
 #define KVM_RMAP_MANY	BIT(0)
 
+#ifndef CONFIG_PREEMPT_RT
 /*
  * rmaps and PTE lists are mostly protected by mmu_lock (the shadow MMU always
  * operates with mmu_lock held for write), but rmaps can be walked without
@@ -1008,7 +1009,8 @@ static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
  * actual locking is the same, but the caller is disallowed from modifying the
  * rmap, and so the unlock flow is a nop if the rmap is/was empty.
  */
-static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap_head)
+static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
+					    struct kvm_rmap_head *rmap_head)
 {
 	unsigned long rmap_val;
 
@@ -1032,6 +1034,35 @@ static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
 	__kvm_rmap_unlock(rmap_head, old_val);
 	preempt_enable();
 }
+#else
+static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
+{
+	return atomic_long_read(&rmap_head->val);
+}
+static unsigned long kvm_rmap_lock(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	return kvm_rmap_get(rmap_head);
+}
+
+static void kvm_rmap_unlock(struct kvm *kvm,
+			    struct kvm_rmap_head *rmap_head,
+			    unsigned long new_val)
+{
+	atomic_long_set_release(&rmap_head->val, new_val);
+}
+
+static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
+					    struct kvm_rmap_head *rmap_head)
+{
+	lockdep_assert_held_read(&kvm->mmu_lock);
+	return kvm_rmap_get(rmap_head);
+}
+
+static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
+				     unsigned long old_val) { }
+#endif
 
 /*
  * Returns the number of pointers in the rmap chain, not counting the new one.
@@ -1745,11 +1776,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	gfn_t gfn;
 	int level;
 
+#ifdef CONFIG_PREEMPT_RT
+	guard(read_lock)(&kvm->mmu_lock);
+#endif
+
 	for (level = PG_LEVEL_4K; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
 		for (gfn = range->start; gfn < range->end;
 		     gfn += KVM_PAGES_PER_HPAGE(level)) {
 			rmap_head = gfn_to_rmap(gfn, level, range->slot);
-			rmap_val = kvm_rmap_lock_readonly(rmap_head);
+			rmap_val = kvm_rmap_lock_readonly(kvm, rmap_head);
 
 			for_each_rmap_spte_lockless(rmap_val, &iter, sptep, old_spte) {
 				if (!is_accessed_spte(old_spte))
