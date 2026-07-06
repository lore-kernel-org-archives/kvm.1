Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56008436BCE
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362046; cv=none; b=Os9ZTwgghvmy3CrjOGzs8Ko2HtYKp0HAoXdxchJambvwCGYlCSfkaWknzDnOzPDzdZ0rY+/OiJ5GDSKJpolIX0Ha0YMoZfAoB7iXJ/LBAPQzqUEiaKfdWXVYR86IKYAq/APzJa+dMvQyXG9Cg6NLSyu+C0g8nRUQwxHcd1BIyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362046; c=relaxed/simple;
	bh=LDxcEz8IwRYGz/FOdDNOCDq5/hYCpTWrOlpBGBPJa14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZSx4sdblgMFFZAOd6zKxw5FKSwNaUzTHEjH9VcQesa+74dEL6ADgVqF4Pg4XlbZKwFzyWJ136cd+V86puZ3yQ9WrZuG8bml24Dd0YCiV4BcWfP60AsTedHL9IaicPkMDoAo6px8d8RnMjsd2Tn8YC5e1OV2TKu+oL6FZ/t16Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkNh50yU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkNh50yU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30D1F000E9;
	Mon,  6 Jul 2026 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362045;
	bh=uxAC+VYYuxWYnxPhLvsEDIHhf+fAfFjfAvJkCvAx1aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkNh50yUriMgi2iHlT0qvmbB64Ao3zdF4Dp5tOIbXvmzvGAQ3JeenSnlhjU3mr1Z9
	 PZ+kt3xhPyYBvvKAK5+XVCUSW3SQX8b4q6cT12UbeY67npMGyfG04M1by6XlEG2oYP
	 ykSEntHtbF21qIFexs4bQIuUtOL0FHCNkbICIyWkvnOvgg+LcU9OO73f1CECN1oqqE
	 99c8KnYaJYJ9oLw1OiyYkZ+eVlomPFwHfCr1GmxuvjY1DhDM54gMqh3KGVj3CHoWFl
	 WdrwwsHgDqJQhIIv2BZBAt2g5DvACuEyiLRe7ILxOVe3ir8n2ImjuTDk48aV7LHya8
	 vS8/X6EZQbIYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before
 destroying vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706180025.2735341-3-bestswngs@gmail.com>
References: <20260705045450.1325048-2-bestswngs@gmail.com>
 <20260706180025.2735341-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:20:44 +0000
Message-Id: <20260706182045.1E30D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free on device error path in kvm_create_pit().
--

commit 738d33431d0b6932537e95c21eed6b24c1201219
Author: Weiming Shi <bestswngs@gmail.com>

KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs

This commit moves the destruction of the in-kernel PIC and IOAPIC to
kvm_arch_pre_destroy_vm(), before vCPUs are freed. This ensures that the
eoi_inject work is cancelled while target APICs remain valid. It prevents
a use-after-free where a delayed work item could dereference a freed vCPU's
APIC map.

Link: https://lore.kernel.org/all/88ba60ad32ba851426a3f6590b0e402210991b4a.=
e33b58ce.0008.4e1c.aa62.c1024b242cbf@bytedance.com/

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index afcac1042947a..38ac0e0a3f769 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13428,10 +13428,14 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
>  	 * Stop all background workers and kthreads before destroying vCPUs, as
>  	 * iterating over vCPUs in a different task while vCPUs are being freed
>  	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
> -	 * be stopped before IRQ routing is freed.
> +	 * be stopped before IRQ routing is freed.  The PIC and IOAPIC need to
> +	 * be destroyed here too, for the same reason, and because they must
> +	 * be destroyed before the KVM buses are torn down.
>  	 */
>  #ifdef CONFIG_KVM_IOAPIC
>  	kvm_free_pit(kvm);
[Severity: High]
This isn't a bug introduced by this patch, but since we are touching the PIT
and IOAPIC destruction paths here, is there a potential use-after-free on t=
he
device error path in kvm_create_pit()?

If host userspace creates a VM, initializes the IRQCHIP, creates a vCPU,
and starts running it, the vCPU can perform PIO exits, calling
kvm_io_bus_read() and acquiring srcu_read_lock(&kvm->srcu).

If userspace concurrently calls KVM_CREATE_PIT2 with the
KVM_PIT_SPEAKER_DUMMY flag, the kernel registers pit->dev on the PIO bus.
The vCPU thread could pick this up.

If the subsequent registration of pit->speaker_dev fails, the error path
unregisters pit->dev but frees it without waiting for SRCU readers:

arch/x86/kvm/i8254.c:kvm_create_pit() {
    ...
fail_register_speaker:
	kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
fail_register_pit:
	mutex_unlock(&kvm->slots_lock);
	kvm_pit_set_reinject(pit, false);
	kthread_destroy_worker(pit->worker);
fail_kthread:
	kfree(pit);
	return NULL;
}

Could the vCPU thread, while iterating over the old bus, dereference
pit->dev->ops and access the freed memory?

> +	kvm_pic_destroy(kvm);
> +	kvm_ioapic_destroy(kvm);
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706180025.2735=
341-3-bestswngs@gmail.com?part=3D1
