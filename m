Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D429AAEA
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645583; cv=none; b=a9g9JN5hxu/VB3MrOLkEPcHSVsJwqmW7RyWX2dRJ+op+m7rPXBU4Tt70N3Aa8QvhyrvDsiUrqablGxZpsZ6XSIKmMQGS668u8XaB4j9INACUCzjIZjdKefSCkO0ooGKOenoCJmd2BFSqUXDfhGB1KGKlSoHJ2MPuJzF7w66QbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645583; c=relaxed/simple;
	bh=kG1tyuyS+WItldZo2it0i/oxAx7WsLezMucv+Vpc6Rc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=AouSNDYLe6CoHV0MTjjzJR8bO8TetZqV5JEgtcErW/s+tcMvk0Edll5SOXlONVdE+jfJhzzbg/A7ml93ev4pgm5J0amO/1M4ExLYrbPj6//GmkbJjInOu9Vu6USaosOKEODlw6p5eYYMg/a9tJ2qNG6BZW9OwazbR0T/Aw3bilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+ZzcndQ; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ZzcndQ"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3413069aa25so2402020eec.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790645581; x=1791250381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jE+ciqEVDFdZu7cLu52zi+3jRoMHY3EWj/NIdDttJpA=;
        b=B+ZzcndQ8GLN3VzS5hRrVPWO1aaAyMjGIbo7uRjVOFQdTs7feh4gf/7n4FcFPV+8o6
         fUdoU0/ynGxPW0QTDW66TMr8uuppu95eo4b2s8Qtx5T0K8lcCKJoK2QP+DuNv/kfC0y+
         UfvAmq8B9bJpqx3zXHw7TqL+CyMJVcXthbUtARMduBlVcTj2wSpOxcdAsMiu7H9NC0Oh
         Ti6598LkT7Hm5WYqc7kTYcYmupc2wnZqUmwKqiy3KpVQ84FEgUbJ7tSfJkvr91i3n7iz
         ve8VzBm0dTz8lYYiQOpd4b1tKo84WL5bSE0zZOpyvvuI4U0cDthU9mihvC263nkUpvB7
         4Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790645581; x=1791250381;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jE+ciqEVDFdZu7cLu52zi+3jRoMHY3EWj/NIdDttJpA=;
        b=itNfkqFQaJeDfn1vCMrOhSpFEp8CFlYn75sTatR3if/HKRrgTPToWLlpWSIERvnSMc
         qS3jtluxaIEA58pBUUTvm3sOvAYVYzZDu/4TXE0JOYSevglo7shQPdtAalxeU3pBCkA7
         XBhqwpsslEfBIiLxCTUUNp8EyS1yttK7RGw8KFqMrzmD4Ry3SuxK/127JvZ0OQx4I6W3
         PSsQpns4cpj2v59jJw48YX6NQU01G6+4G0hPabAtKHHldzzfUusJRlqq3QV++ocNYq+D
         USHy6p8RBxNWnI2NXwu6EaoE6HTxIbxRAC9Td5PhCQcdhILx8vmlCw3StEaJO9AaCBMM
         RIWg==
X-Gm-Message-State: AFq9FYK/0nA6Ao/Wgk1ezm3PXd1/NPha6SbFWq2W17xmK8Uk25lNgqnv
	3yAnVhuDPESOs61bo94pNWoBMf/iKZmwkivfQyuEw+WMwPlArAryYxWvweY5EQOa
X-Gm-Gg: AYBFou0I76eR/b2arXiGndX8v68WJZDVqXOuVHF/Lq5nFhDXG7V6jvffo9SifQLbZP8
	fJcqWbiDqZbaw1L866pvM4TnSIMCrnn/XClW1YWQ/MVl6q0en19uBE93shJR9MbdF4oGesx4BuO
	b92EP8PKp1txoiXb9ZcyLZokNeu8RIQ4Ovmr+IwToPrEETWERZvFmBKsCnKUfhlZTz2ZZKjEglB
	TGawzpvTWWQYqIsSF+IZ2P3Zv3BFMyqRe0NwHNMEimMDkIb439GWR5bntYIb0vLBlYxoPOk3KhB
	3qlGfiq20W1mz/f7vnLS96Z1nBDiN+/6zK+M6mGOgV4bnsErEJA0xXWEpl9cs1a+vbjVrQHqNGi
	lgawKQz2fs0csPADqA0dXv1dWUjl5aCM14yqtWdL807N+hV8k/mqNLXwK2KCG2huIVjEEmRUnwu
	mvfXcSSPIPhxI43R4O4URE2ND/PXBqdCCqF9osXXL1lgDJlKhzvP1qrAmkPlfv0x/djkGzJX+zd
	w9w20XpcYZrUqXYo6SRbs1B4yw+wdlkgufSRAZrQXbuD06nrgwWxZQ=
X-Received: by 2002:a05:693c:8953:10b0:346:7bfd:8504 with SMTP id 5a478bee46e88-3467bfd8655mr7218954eec.41.1790645580580;
        Mon, 28 Sep 2026 18:33:00 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34b580fc50asm466353eec.14.2026.09.28.18.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:32:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
In-Reply-To: <20260922184312.9FAAB1F000FF@smtp.kernel.org>
Date: Tue, 29 Sep 2026 06:41:49 +0530
Message-ID: <qzickgiy.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com> <20260922184312.9FAAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: selftests: missing save/restore of %r1 and %r2 in ex_regs
> --
>
> commit 2e259a0445aae14d6a7262b100f4677735b2217f
> Author: Nicholas Piggin <npiggin@gmail.com>
>
> KVM: PPC: selftests: add support for powerpc
>
> This commit implements KVM selftests support for powerpc (Book3S-64). It
> provides virtual memory implementation for the radix MMU, ucalls using an
> unsupported PAPR hcall number, and real-mode guest interrupts.
>
> Link: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list@gmail.com/
>
>> diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
>> new file mode 100644
>> index 0000000000000..b860f6a520a13
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
>
> [ ... ]
>
>> +virt_handle_interrupt:
>> +	stdu	%r1,-INT_FRAME_SIZE(%r1)
>> +	mr	%r3,%r31
>
> [ ... ]
>
>> +	mtxer	%r8
>> +	mtcr	%r9
>> +reg=4
>> +	ld	%r0,(0*8)(%r31)
>> +	ld	%r3,(3*8)(%r31)
>> +.rept 28
>> +	ld	reg,(reg*8)(%r31)
>> +	reg=reg+1
>> +.endr
>
> [Severity: Medium]
> Does this restore loop in virt_handle_interrupt intentionally skip restoring
> %r1 (stack pointer) and %r2 (TOC base)?
>
> Because the loop starts at reg=4 and ends at %r31, any changes made to the
> stack pointer or TOC base by the C exception handler in the ex_regs
> structure will be silently ignored when returning to the guest.
>

That is intentional since it is unnecessary.


>> +	addi	%r1,%r1,INT_FRAME_SIZE
>> +	rfid
>> +
>> +virt_handle_interrupt_p:
>> +	.llong virt_handle_interrupt
>> +
>> +handle_interrupt:
>> +reg=4
>> +.rept 28
>> +	std	reg,(reg*8)(%r13)
>> +	reg=reg+1
>> +.endr
>
> [Severity: Medium]
> Similarly, does handle_interrupt skip saving %r1 and %r2 into the ex_regs
> structure before routing to the C handler? 
>
> If a selftest takes an exception and attempts to inspect the interrupted
> stack or TOC by reading regs->gprs[1] or regs->gprs[2], won't it receive
> uninitialized values instead of the actual register states?
>

ditto. None of the tests depend on it.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1790101179.git.ritesh.list@gmail.com?part=1
