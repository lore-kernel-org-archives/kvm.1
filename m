Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EE40F8FC;
	Thu,  6 Aug 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005544; cv=none; b=JtHu61P10UMmmsSOsXz7knyI52wnr954wpJuNX5/iBc1aXFhWlojq/JI/tw1JkeOWWDh4xrCnz9sY/Bh6bV4JG7FA7nnzamfqwqoCB+wK4kM+gvBd4RiEGunjX2yk8LXxwjkYr3VqgLfRKsINxxQeXU+r+PvrRPlI1S5zudDjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005544; c=relaxed/simple;
	bh=9nIA4g8t7lcsSLy8SKolUFQCcXI9D58a3Po16VlQMr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBFVK1y10b6ZarHuWSInXnaxH1gum9Rrfk1MyAFGbLgKb1KpRXtoo2kDF1NDLxWDmkqWOphdvpbezTBq/7uStCxqxX8eW5PXoglTjumc7iuUfDwkxy78rO04WofQ6c+NXoZ4/hzip7jxVcAcvbIQLZ7knFtQ0sOW74iotAT+IAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHTUUJud; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZTgQaNPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHTUUJud";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTgQaNPB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786005532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nIA4g8t7lcsSLy8SKolUFQCcXI9D58a3Po16VlQMr8=;
	b=FHTUUJudzFS9p3kUWAKr1SALxyX8dITqDTYMVXAx1huMmCgpVLP16nMVY4hcklrJVWcPqR
	w7xImKjr/LQ01tnIrxqVA3UoQHb5TfPHrNmNcr3eIZeGHvSLPuf82pFFMpcMWyY10ggoMy
	6M8g3cUMahaQwRseVEhEYmG1lOJoXFKPwkOVGeUp7vlqmw1KZIqDuCmYf7BySxV4CtRqbn
	x0cePGBoIA0fRtAPfgYtQhpjZh0okiLhwau7Yp6CYyhdXK8F3j98Gh1gIGB9q4/54UFNG6
	MO9amqq1MPvisx9UdAuDyFTvTnWiUYEHsIlwEykL7w0mVNt9CkDznC0ZIY1VFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786005532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nIA4g8t7lcsSLy8SKolUFQCcXI9D58a3Po16VlQMr8=;
	b=ZTgQaNPBgxMk/DdAp7Z2FCXvOe+jMg5wVDgIbdDAwvGdPZW+a8kUN6/Kjq+YrXGTVD/0FE
	PyrDu/wCuK5cK8BQ==
To: Charlie Jenkins <thecharlesjenkins@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins
 <thecharlesjenkins@gmail.com>, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v3 07/17] riscv: Maintain epc on misaligned emulation error
In-Reply-To: <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 10:38:51 +0200
Message-ID: <87cxvvd4o4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> Currently the epc is set to zero when there is a misaligned emulation
> error. This will print a misleading error message with the current epc
> value of zero instead of the epc value that triggered the emulation.
> Avoid setting epc to zero to maintain the state of epc.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

I see no reason why epc must be set to zero, so:
Reviewed-by: Nam Cao <namcao@linutronix.de>

But to be sure, I add to CC: Damien Le Moal <damien.lemoal@wdc.com>

Damien, any reason that epc must be cleared?

Nam
