Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266716FF37
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552791; cv=none; b=min2tWCpkT6J0l6Xt0kRy0uPvpsoGFZext5AhqICVT9cu4vlm/HN9Jy6p8MBccarF2cdTETQE/5uEQYRCydYENpvljqanS+nVuet0UrOB/HCwMmGhwbhCuW3TIRrtialGGmTzAyRvbZJwCr4ntsytxuLOp5oZWfkP5V8LeGwfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552791; c=relaxed/simple;
	bh=Nr4ykG9bI1j7F9yOAiCgT12j2VzKdu81DmQ7yoqlreQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=bn+lyTKi6NnoyOk/TnwXgz4e6W1vO14hHv4QSTAD0gQ9QcxItgPfdC51YCdWzJOjPyvSkAPN2ZcxiF6zbGfDMQQ0zHjaw2/FqwYXpKy8D3963PpaR4UyEJHplCt3xmg61/CZtY9wSh7kmrBnx14lRi6FxQyoY7QDXhQm/iRPreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/cP/3nB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/cP/3nB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so2095955b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552790; x=1776157590; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LIxZ8JviT+7bT0Znc35dMuHV2Q7OKrp+nJNAYhLWoWg=;
        b=h/cP/3nBWEzVCwXbh+nOjG1Gq8Q0SGrts1bpt27PCVxHLeW9/OQBO8E4Fzs3H42jDT
         eTPTNc3q4zeCrrDyApVYtooRRJ+t+5jLxkaDLoc4EGsPooxatlxaZFupz5KmAb/BQQJ8
         XFnL7j+ZkNl7EAEyjeMJv4wahICpnzl+Lc29sbyDrrvAvTQCpx4D1iaUgXxK/LDxbkE5
         /xOnRWfJEo+NGYTvNJxQban3QfYwi7mkeBROfGQnz9ga/h82uhhbbzbBOOefL95zvmb4
         B0bSc/2LuVd0hsJUjV3ABTa76loTkdyS2zgv/0MhrQfhFYhyc3FFfQMBroFfTB+ArwN+
         c2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552790; x=1776157590;
        h=content-transfer-encoding:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIxZ8JviT+7bT0Znc35dMuHV2Q7OKrp+nJNAYhLWoWg=;
        b=XkRbBI/gsTQ8n8P0x2fscjhFZY0RJsSpIUvQ3n82qx4DJ2sInm5Sxbmsun5hpvD/DC
         3F9R0THCTTrWtGWjWCDtAQvHg8fJMUWX8FF7ay7S4kB2YLh5z1Ez4ACbNoHH2X2/O9m1
         ZaqTulAlDut0UD4mLkfCm3bRebNfUPO7NijQjYBBuBzZY5IgUjUorv50x9v9dpfR4S1B
         UADPXUnimpkOid/Lkv5efMOIw2hmwNMCk3qn9xfHmObfaU82DmtXjT+a7xARHTCjqiQq
         oPnr6zQb0rCLfXuMEHbkA24AYq6sAs1VZ0b/U15GkKEgaiKX/RjX65oCaOZ08/BC/3cG
         8sTA==
X-Gm-Message-State: AOJu0YyoP5pt5oKWwedS8izCeEXSmg6rVsp3u/lbtNk0GZ5PtxJkBfvl
	AwBEKlo0MVM4ZEmfgQ6LBmZNNjEOwzVO7j/G1ARUVQFSrL5ma/3QiHhwCA3KkWO46QsYayUQdwQ
	=
X-Gm-Gg: AeBDiesZzUqiznVWnyQCiYg34BEsZzdacTWjpe7tEqmPjXIFv/VGRvkkVAHjLnM/4g6
	y+TYMvYL6K9+fCx3mJUNc9j7BHdv8LEtEX1khHqv97M6edTfXr1kTXB34BD3GfXlpqVkCr449YY
	ySr/n0BRTaa9g1LZcfu+4ATuwPUvRPrDJ19M2VWQuJSr0k2J1tHG2q7fHbckFN6OGmcCfW2VBij
	kYfp0FNbz10ZkqCy10AfRnN1M4BTD91QvcksmseC3PRJwg9SWOK1+Q+iVL8PPNU9WDmqpKBWrNl
	Fxj2J9Jlg5VG2jlNULkAzPC1mNuyQfTOWrXM22vkaHB3fcTHUyLlzhS5+f1J6UeCvKJ8Wh5fcYg
	1J5h12KLjOap9ojgVlquDfgE+Mj4VHxxDu4e9dZjmOtOZJUsuOCablp5u31IH1nB85D5bEiKLOh
	sF+B1WRnRIIul7n8bLQ7K/qzNE78Rgpd2CHEevlF9MuQ==
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-39f2ed8d9e7mr16569249637.19.1775552789549;
        Tue, 07 Apr 2026 02:06:29 -0700 (PDT)
Received: from [172.16.80.87] ([162.219.34.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65995a9sm14442848a12.27.2026.04.07.02.06.28
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:06:29 -0700 (PDT)
Message-ID: <e3343610-d0d9-4572-baf1-9417f31aa8ff@gmail.com>
Date: Tue, 7 Apr 2026 17:06:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [HELP] Host seems to use address from Guest after vm-exit of external
 interrupt
To: kvm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear respected kernel developers,

I hope this email finds you well. I am writing to humbly ask for your guidance regarding a puzzling behavior we have 
observed on a KVM/QEMU host.

Environment:
 - Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz (family: 0x6, model: 0x55, stepping: 0x7)
 - microcode: sig=0x50657, pf=0x80, revision=0x5003102
 - Linux Kernel version kernel-5.14.0-162.18.1.el9_1 + some patches from upstream
 - Qemu 9.1.2
 - Guest Kernel 6.12.13
 - ept and vpid are enabled

An external interrupt arrives, 0xfb IPI, in this case, then guest vm-exit,
Look into the kernel stack of kvm thread on task_struct.thread.sp, there are many
odd addresses in the stack, __per_cpu_end+-xxxxx. These addresses seem to be
address of guest kernel. handle_external_interrupt_irqoff() get a guest kernel
address from host_idt_base and run it well, the pt_regs on ffffa2970359bcb8 looks
well. The code traps into page fault on irqentry_enter + 0x11 which need to access
percpu variable with gs. On the lower address of stack, page fault on guest kernel
address traps into fault again and again due to accesses per-cpu variable with gs
util stack is used up.

Could anyone kindly point us in the right direction? Any advice on further debugging
would be deeply appreciated.

ffffa2970359bc00:  0000000000000000 ffffa2970359bcb8 
ffffa2970359bc10:  0000000000000000 0000000000000000 
ffffa2970359bc20:  0000000000000000 0000000000000000 
ffffa2970359bc30:  0000000000000000 0000000000000000 
ffffa2970359bc40:  __per_cpu_end+-2120405404 0000000000000000 
                   ffffffff81a00e64
                   [native_irq_return_iret]
ffffa2970359bc50:  0000000000000000 ffffa2970359bcb8 
ffffa2970359bc60:  ffffffffffffffff __per_cpu_end+-2121729727 
                                    ffffffff818bd941
                                    [irqentry_enter + 0x11]
ffffa2970359bc70:  0000000000000010 0000000000010046 
ffffa2970359bc80:  ffffa2970359bc98 0000000000000018 
ffffa2970359bc90:  ffff9112110c0600 __per_cpu_end+-2121733493 
                                    ffffffff818bca8b
                                    [sysvec_call_function_single + 0xb]
ffffa2970359bca0:  0000000000000000 0000000000000000 
ffffa2970359bcb0:  __per_cpu_end+-2120405754 ffff913a8ede4600 
                   ffffffff81a00d06
                   [asm_sysvec_call_function_single+0x22]
ffffa2970359bcc0:  ffff9114a6d78048 0000000000000000 
ffffa2970359bcd0:  0000000000000000 ffffa2970359bd60 
ffffa2970359bce0:  ffff9114a6d78000 0000000000000000 
ffffa2970359bcf0:  0000000000000000 0000000000000000 
ffffa2970359bd00:  0000000000000000 0000000000000c01 
ffffa2970359bd10:  013f7de9845dc650 ffffffff00000000 
ffffa2970359bd20:  00000000800000fb __per_cpu_end+-2120405776 
                                    ffffffff81a00cf0
                                    [asm_sysvec_call_function_single]
ffffa2970359bd30:  ffffffffffffffff vmx_do_interrupt_nmi_irqoff+16 
ffffa2970359bd40:  0000000000000010 0000000000000086 
ffffa2970359bd50:  ffffa2970359bd60 0000000000000018 
ffffa2970359bd60:  ffffa2970359be00 vmx_handle_exit_irqoff+312 
ffffa2970359bd70:  ffff9114a6d78000 vcpu_enter_guest+2556 
ffffa2970359bd80:  0000000000000019 ffff911229542f80 
ffffa2970359bd90:  ffff915000000040 ffff9114a6d78038 
ffffa2970359bda0:  ffffffff00000004 f1f09fe6388c6600 
ffffa2970359bdb0:  ffff911229542380 f1f09fe6388c6600 
ffffa2970359bdc0:  0000000000000002 f1f09fe6388c6600 
ffffa2970359bdd0:  ffff9114a6d78038 ffff9114a6d78000 
ffffa2970359bde0:  0000000000000001 ffff9114a6d78038 
ffffa2970359bdf0:  ffff9114a6d78048 ffff913a8ede4600


Best Regards
Jianchao
