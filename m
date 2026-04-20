Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782234FF5D
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697213; cv=none; b=ENE538ub3j9FKi4uqvcS5H9sp5R1TORA712kvh2EnUeYkI2vrNo1RJkcqCJ6FR8L2IR8xMIKGP9nQ/GTZIppqj+RMlcmgS1DuvYL0mQh7lV0GZxg+W6IGRUWaSsz/3YF0WGNFZ+XgN/IJHDDgslWsh2yzdBW8o7Xra4URXngr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697213; c=relaxed/simple;
	bh=sfVdhgmOAS+yVewcGfs7PIZdmTkqC6cO6oiwZDBFanA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buwdd8Vl4goVQpkni2P5xGjjuONDVzlmyVgDO2yXB8mYHE2f6DIx6xzqYliWNYWtz3P2XLreZDBvd23jkl2i0ibZ4Owswhn/nec4HBoYBkL/E4AJqIsITNkFuI0jLjADBcaNe+ICdV0ZsP457IsHxv9Ra9SRow5O0ikw7YpRK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lat6iJ9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lat6iJ9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3DFC19425;
	Mon, 20 Apr 2026 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697213;
	bh=sfVdhgmOAS+yVewcGfs7PIZdmTkqC6cO6oiwZDBFanA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lat6iJ9XMHq9+H3KRVunMEtcUTdIY72RTgeMtFVE8HAYu6QuxH94hcijhHnEUrK6u
	 ilajLBpJWqdQqR0KD9Bjmru1kdGs+JyZhpbm7ChDPIifUaCQ90VbE+jA7gJ+ECejsv
	 hV1n8HKR2xvqHE58gA9k0LLfZqwIIjKAgPyY4/pfeGihrsafZ+24QQbFsYSzqnl0VA
	 bkIASxQtxfgw+tgRKxuIHfdHOl2LFcnbP9qk/0kdpozeeC4KXbt693WrZtworru7yD
	 7W1fo3yeHrTvBFiV+Jt068m0lDb9eJoHxyNjwAayhOQ1PyxsiSP0F0eKYjovk29tds
	 hXIuOO+OusAKA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "peterz@infradead.org"
 <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
Date: Mon, 20 Apr 2026 17:00:09 +0200
Message-ID: <87mryxekxy.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 16 2026 at 20:50, Vishal L. Verma wrote:
> I tried out AI assisted and patch (below) which does happen to solve
> it, but I'm not familiar in this area, and not sure if this is the
> right fix.
>
> diff --git a/include/linux/entry-virt.h b/include/linux/entry-virt.h
> index bfa767702d9a..c4856c252412 100644
> --- a/include/linux/entry-virt.h
> +++ b/include/linux/entry-virt.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/static_call_types.h>
>  #include <linux/resume_user_mode.h>
> +#include <linux/hrtimer_rearm.h>
>  #include <linux/syscalls.h>
>  #include <linux/seccomp.h>
>  #include <linux/sched.h>
> @@ -58,6 +59,7 @@ int xfer_to_guest_mode_handle_work(void);
>  static inline void xfer_to_guest_mode_prepare(void)
>  {
>         lockdep_assert_irqs_disabled();
> +       hrtimer_rearm_deferred();
>         tick_nohz_user_enter_prepare();


This code should never be reached with a rearm pending. Something else
went wrong earlier. So while the patch "works" it papers over the
underlying problem.

Can you please do the following:

    1) Apply the patch below

    2) Enable function tracing and the hrtimer* trace events

    3) Enable tracing if it has been disabled already

       echo 1 >/sys/kernel/tracing/tracing_on

    4) Run the tests and wait for /sys/kernel/tracing/tracing_on to
       become 0, which means the problem triggered.

    5) Retrieve the trace from /sys/kernel/tracing/trace and provide it
       somewhere to download from or send it to me compressed offlist.

Thanks,

        tglx
---

diff --git a/include/linux/entry-virt.h b/include/linux/entry-virt.h
index bfa767702d9a..ab73963a7496 100644
--- a/include/linux/entry-virt.h
+++ b/include/linux/entry-virt.h
@@ -58,6 +58,10 @@ int xfer_to_guest_mode_handle_work(void);
 static inline void xfer_to_guest_mode_prepare(void)
 {
 	lockdep_assert_irqs_disabled();
+	if (test_thread_flag(TIF_HRTIMER_REARM)) {
+		tracing_off();
+		hrtimer_rearm_deferred();
+	}
 	tick_nohz_user_enter_prepare();
 }
 
