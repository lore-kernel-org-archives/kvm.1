Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBF479889;
	Thu,  6 Aug 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028678; cv=none; b=X1GJ2Sb9U6RKBUx7ntWafTYqics+Foe/3b1otmLkxQItZ3Z35hYBy747N7UWSMniFyGLemXMfppmjOXkuUk2AtnZUK5sZ+w8M6mrFRrpu1r7qfsWzr9RYj/Ki1hA2oREv7CfnJ1FNx6AfAnhLaTpGhLrUv07N7jNEj4+PZDquEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028678; c=relaxed/simple;
	bh=UEUvpsPuzYYsANoBuWHaBmcQH92bNoFobnw1vCDeyb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C79mfF4fY2WuVTv/HIvPp0H0/GxA5UTPk90mWg+sFwtLXdzT8WPe5L+Eh8FD/R4obN+OyH1TPiTcoi+yX726zVprBfpVXQV/FiNHg90pDdQa94WWHj9WLpnpI0qF7l0cXcpZwGcgIHxprD/O9THU6bD6w3Nn7J3h8YqwgMkfzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QkUwySVI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JENUJOs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QkUwySVI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JENUJOs"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786028672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5vYlEkYi9o51c1f/TTbOEXeh8TYKvmeJYU6kzjXqK0=;
	b=QkUwySVI4FE+trCJg6qqAkkIQpJKeDzsTJkM/04av9tzmUFPPSCmB6Ebxp9gItEVMxIZo7
	621j1qmWIS+Ukkt9qendBqtWOfCcmzbHMzzriK8LKxEb8evczh3qYgWgjtbH+5JG6v8rDS
	JYXgmicXB/3zra9Hsvthh/KNO3HDZU+kUbGSoMOWwmZNnPinX7rILW7a6RIUtk6mqErhnq
	gFjycxfe/58mLJ6vnevJy8WZKcpIO6PBhz/aNCt9XKTNEf0fcnyGO/hv11Z9PciRHy0pcr
	mflWHyF546ffgzA1P0Ag7VpSJUG1dTyJEh6ZzmaSKabhF7Svuytu1ZhaeFvEZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786028672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5vYlEkYi9o51c1f/TTbOEXeh8TYKvmeJYU6kzjXqK0=;
	b=6JENUJOs/buVuvrTF2FobfkdDbOVwiZPmC5wy2FFshSHbQAnTyfRR+bza8a2IMq3uwTOoF
	XicK9QKeAMCztPDQ==
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
 <thecharlesjenkins@gmail.com>
Subject: Re: [PATCH v3 09/17] riscv: kvm: Use generated instruction headers
 for csr code
In-Reply-To: <20260707-riscv_insn_table-v3-9-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-9-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 17:04:32 +0200
Message-ID: <87fr0rl27z.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> +		wr_mask =3D GET_REG(riscv_insn_csrrwi_extract_imm(insn));

  CC      arch/riscv/kvm/vcpu_insn.o
arch/riscv/kvm/vcpu_insn.c: In function =E2=80=98csr_insn=E2=80=99:
arch/riscv/kvm/vcpu_insn.c:186:27: error: implicit declaration of function =
=E2=80=98GET_REG=E2=80=99; did you mean =E2=80=98ET_REL=E2=80=99? [-Wimplic=
it-function-declaration]
  186 |                 wr_mask =3D GET_REG(riscv_insn_csrrwi_extract_imm(i=
nsn));
      |                           ^~~~~~~
      |                           ET_REL
