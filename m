Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9323A5E97;
	Thu,  7 May 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171683; cv=none; b=JHdKKk9L8rYpmhn1HsSIejFCYyjbDTAhNgLnEhHA5LvV81uZKh0jnbVaWs9KCTllZzzDfNqoVmItZENYX+uaD+0WPLfPePcpj/pnPf0l2BRsmNcmyTxLADOkrf3CJi+vIB5H5tdrtzaQmB3/kZZdNTBDotPfoVaoljbsr1qCcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171683; c=relaxed/simple;
	bh=IX4j+KXjMqm1cT++0NVi6uSCU0kxWxNvVJir+5TlHHs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tU+D6dq1koYhb5Ee3BCSQaMAEuGBBEV2glpVdUsiAZp5JUaSqcATEJdYYq0UZZQLe+CcKjjQv0omsW7zsHIXCY+rFid3FAFtY8nRwnqHsHD8w+STRreYBgTOS+dIM8WiPnwAAuFq60EH5mylexlDsMZzI87652j+N+TjalE52zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sjBbcl6X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sjBbcl6X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pw0d7TJg62h/MzpaFohoRRf/ofQWSP3GEU76wkiH020=; b=sjBbcl6XJtP3h5EBE7x3db22wl
	fPuACPAz/4XNqHYDmKuICUpqJbpb87XdbMvZmelrSc65SUzuoz96RFBZEZ2BNreqfaVjYdxZYhESa
	sU61V5OQGeI2fDWdqCJDRSJpFCf4xXFTwT4ppdmP58O0MIoLPJIq9B8wipprByy/fYruBRUCwJg7b
	tiXOiXkfGDeejMZQzrYVx3YsOM6Xtt9CK3duK2BfZZnPePes70hy2Ihfb9QJj/ZllMAsUTFqSLHRw
	iBlGyQfgeANCDUDZ5ro0a5Y2gRDfPGz/csLnxjk+VH7hxCoeUdcPLOvMMmofu+fANwK3EmpBw+DGJ
	9ikUsN5g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wL1fx-007UMs-5K; Thu, 07 May 2026 18:34:12 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wL1ft-000Pi8-Rn; Thu, 07 May 2026 18:34:12 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wL1ft-00000004Nnn-0s6x;
	Thu, 07 May 2026 18:34:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 May 2026 13:34:09 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kernel-dev@igalia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
In-Reply-To: <9bc8666e63d7de8b32dd23934fe0097f98d72726.camel@infradead.org>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
 <e23df9d183c2c421946ea73b8053e4c4@igalia.com>
 <876c720ab963f550d3166b067f6457fcd78ec415.camel@infradead.org>
 <122adcacb2a6ccc3a5b78c750fe85e0b@igalia.com>
 <9bc8666e63d7de8b32dd23934fe0097f98d72726.camel@infradead.org>
Message-ID: <d47d2c7e58abed48332902e34f4e9984@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.2, Tests=ALL_TRUSTED=-3,AWL=-2.040,BAYES_50=0.8
X-Spam-Score: -41
X-Spam-Bar: ----

On 2026-05-07 13:15, David Woodhouse wrote:
> On Thu, 2026-05-07 at 13:02 -0300, Mauricio Faria de Oliveira wrote:
>> On 2026-05-07 12:22, David Woodhouse wrote:
>> > On Thu, 2026-05-07 at 11:56 -0300, Mauricio Faria de Oliveira wrote:
>> > > On 2026-05-07 03:58, David Woodhouse wrote:
>> > > > On Wed, 2026-05-06 at 23:36 -0300, Mauricio Faria de Oliveira wrote:
>> > > > > kvm_xen_set_evtchn_fast() calls read_lock_irqsave(), which might block
>> > > > > on PREEMPT_RT, but that is invalid in IRQ context, as when it's called
>> > > > > by xen_timer_callback() (even on PREEMPT_RT per HRTIMER_MODE_ABS_HARD).
>> > > > > 
>> > > > > Check for that case, and bail out early.
>> > > > > 
>> > > > > Note: there is previous work and discussion on this [1] (~2 years ago),
>> > > > > which involved continuing to execute the function with changes, but it
>> > > > > was not merged. That was a different, more complex approach.
>> > > > > 
>> > > > > [1] https://lore.kernel.org/lkml/ZdPQVP7eejq3eFjc@google.com/
>> > > > 
>> > > > ...
>> > > > 
>> > > > > +	/* Bail in IRQ context on PREEMPT_RT; read_lock_irqsave() might block */
>> > > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq())
>> > > > > +		goto out;
>> > > > 
>> > > > 
>> > > > The approach in Paul's earlier patch was better; we absolutely *want*
>> > > > to deliver the interrupt to the guest immediately whenever we can, and
>> > > > only fall back to the workqueue in the rare case that the shared info
>> > > > page has been invalidated.
>> > > 
>> > > Certainly, that was better. This was a simple workaround, but with this
>> > > clarification, it indeed doesn't fit.
>> > > 
>> > > > We should switch to plain read_trylock(), *without* the
>> > > > local_irq_save(). And since this was the *only* case where the GPC lock
>> > > > was ever taken under IRQ¹, all the GPC locking can drop the _irq part.
>> > > 
>> > > Ok, I can take a look. Or do you plan to work on it yourself (as you
>> > > hit the issue with read_unlock later in this thread)?
>> > 
>> > I'm working on it now; thanks.
>> 
>> Ok, thanks; I'll drop this. Could you please Cc me when you send it out?
>> 
>> > Currently confused by the fact that the read_trylock() seems to fail
>> > more often than it should under RT, causing the fallback path to be
>> > taken... and the fallback path doesn't seem to work properly...
>> > 
>> > Your version should have seen this too, surely? Did the selftest in
>> > linux/tools/testing/selftests/kvm/x86/xen_shinfo_test work with your
>> > patch?
>> 
>> Yes, it works, apparently. Timing is similar with/without PREEMPT_RT.
> 
> Huh. Something weird going on for me. Would you mind confirming it
> still works with my version:
> 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-stealtime

Yes, it also works with that tree [1].

Is PREEMPT_RT enabled in the Xen guest as well? In earlier tests, that
caused interrupt issues on boot (a few 'nobody cared, try irqpoll' and
'Disabled IRQ #'), but that also happened without changes in the Xen
host kernel, thus not a regression, and I disabled it as couldn't look
further then.

[1] HEAD at commit 916875860566 ("locking/rt: Use
raw_spin_lock_irqsave() in __rwbase_read_unlock()")

Hope this helps,

-- 
Mauricio
