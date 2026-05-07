Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C6359703;
	Thu,  7 May 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169782; cv=none; b=RtKjgQo3E6Vv6YtelX/ubQpUSg7++cOw06gqsxTo6BhxER1es1Jm1kYEfT+wWDnWZkE3lT+Hn0l96cUYiUzGr64t/G02iodYeoDFVEM2qnWc5d+PqyrK/WUttBQyl9Y48wE+sYLvXOQOmJx0EyUtHNy+tsY0am4MJFu7X2pjJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169782; c=relaxed/simple;
	bh=Th1hjQuufLS9REOhWsexKk/7cmOrb46IkaHoblflYaY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E3Cg4UId4DM9PNIBBNdne5NgXF6kP4xmUvPjEWmvv6wrx1YhMkaE3+ioIv/I398pzLeqvvqjJGKD4UtglLv7q4GfXpFQ9iL0NjBiO9tQJGFi3rZWAomiwtDWBJaEYW+Arm9Y/0DFkLWsuCKWHVRCLrCMm5rl7X93WOuIhJMnlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SpK/ExbU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SpK/ExbU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e+2rMOcxQiS7pmWEbLk0qHzSpsi+HafNxyucucuvAOU=; b=SpK/ExbUBb0rHe93ZvL4ZniPPO
	YfvvQXnE9pASIF5Cji+pILzYGQfQjlz4aPx0WvpZANcpqFxzwcFSxjL5UjXOo+QjROswINdJW4DcJ
	ZljJGq0X57/oQom+UtIOV6qgOssGjlyok6i/vbOL5OHdsZcAxZu56xg28gE4NyujtVZONNR2JmERU
	HAKkmwv4pz5kod/ZqRLtffaIJ4QE3FsHGkvZcZD3qx0TRT+VXFCKN4NLRsiX5ZlnosIyi1tlrTJoZ
	x8MTdcS4fHH6UfYIqiTRYQeAGqWu6b8X8pn99nl2AH+c9y5yxVPYtfQmpvtrldo7huuzzJrTHCtk2
	QJP5+hDg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wL1B8-007TXP-Ab; Thu, 07 May 2026 18:02:21 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wL1B5-000NUo-5I; Thu, 07 May 2026 18:02:21 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wL1B4-00000004NMS-28cN;
	Thu, 07 May 2026 18:02:18 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 May 2026 13:02:18 -0300
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
In-Reply-To: <876c720ab963f550d3166b067f6457fcd78ec415.camel@infradead.org>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
 <e23df9d183c2c421946ea73b8053e4c4@igalia.com>
 <876c720ab963f550d3166b067f6457fcd78ec415.camel@infradead.org>
Message-ID: <122adcacb2a6ccc3a5b78c750fe85e0b@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-3.9, Tests=ALL_TRUSTED=-3,AWL=-1.700,BAYES_50=0.8
X-Spam-Score: -38
X-Spam-Bar: ---

On 2026-05-07 12:22, David Woodhouse wrote:
> On Thu, 2026-05-07 at 11:56 -0300, Mauricio Faria de Oliveira wrote:
>> On 2026-05-07 03:58, David Woodhouse wrote:
>> > On Wed, 2026-05-06 at 23:36 -0300, Mauricio Faria de Oliveira wrote:
>> > > kvm_xen_set_evtchn_fast() calls read_lock_irqsave(), which might block
>> > > on PREEMPT_RT, but that is invalid in IRQ context, as when it's called
>> > > by xen_timer_callback() (even on PREEMPT_RT per HRTIMER_MODE_ABS_HARD).
>> > > 
>> > > Check for that case, and bail out early.
>> > > 
>> > > Note: there is previous work and discussion on this [1] (~2 years ago),
>> > > which involved continuing to execute the function with changes, but it
>> > > was not merged. That was a different, more complex approach.
>> > > 
>> > > [1] https://lore.kernel.org/lkml/ZdPQVP7eejq3eFjc@google.com/
>> > 
>> > ...
>> > 
>> > > +	/* Bail in IRQ context on PREEMPT_RT; read_lock_irqsave() might block */
>> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq())
>> > > +		goto out;
>> > 
>> > 
>> > The approach in Paul's earlier patch was better; we absolutely *want*
>> > to deliver the interrupt to the guest immediately whenever we can, and
>> > only fall back to the workqueue in the rare case that the shared info
>> > page has been invalidated.
>> 
>> Certainly, that was better. This was a simple workaround, but with this
>> clarification, it indeed doesn't fit.
>> 
>> > We should switch to plain read_trylock(), *without* the
>> > local_irq_save(). And since this was the *only* case where the GPC lock
>> > was ever taken under IRQ¹, all the GPC locking can drop the _irq part.
>> 
>> Ok, I can take a look. Or do you plan to work on it yourself (as you
>> hit the issue with read_unlock later in this thread)?
> 
> I'm working on it now; thanks.

Ok, thanks; I'll drop this. Could you please Cc me when you send it out?

> Currently confused by the fact that the read_trylock() seems to fail
> more often than it should under RT, causing the fallback path to be
> taken... and the fallback path doesn't seem to work properly...
> 
> Your version should have seen this too, surely? Did the selftest in
> linux/tools/testing/selftests/kvm/x86/xen_shinfo_test work with your
> patch?

Yes, it works, apparently. Timing is similar with/without PREEMPT_RT.

# dmesg -C
# time ./xen_shinfo_test
Random seed: 0x6b8b4567

real    0m4.064s
user    0m1.654s
sys     0m4.915s
# echo $?
0
# dmesg
#

-- 
Mauricio
