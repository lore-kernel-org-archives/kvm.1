Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4299175A9A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264351; cv=none; b=DgUTxfWYxXwxeUvWfpAJfn6N5sQYxK+OIrSz88JZ8rQlylu3FmQoqtDP7qVUaaJkDrVcz78KM5E59EYONfzEPwdpZRzD0lsvXPGYFATazRZySDXirs5TZuuQRE9ELMGyiMsfLIHMlQl55uygu1lP4/HY+OX5AQ6ZfHiHuBzlnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264351; c=relaxed/simple;
	bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SJTDIp+g8W/2uHbNOO8oTm4t5qRzNFTNGf+9CwhwO8psd/mchsmNvKBlcfuoo74h68wEQBM4/Cg5g3lLB9IFWodD8am8IKwR3uJkh6PGu7ZrZwDv6NCuLN06jtOMydeZx40TqrZaEth1Uigq8wa70y7EIb56sJ0hfJ6EWCxh/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swf3daqR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swf3daqR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6d3851e09so1432015ad.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782264350; x=1782869150; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
        b=swf3daqRHgoM3c78eWw5aWEMI6WIxftiWzdHvQMsdtpchDM7vhuLoh3XcvfTlsh/fF
         4xuhsgTlGRo9mxjaFiOVxzks0nJejtGNxD22WEJ8n5VtA+jMY8pRZA4SPCd1QQ/E1jiy
         CSCYgUBZ5wCePJ4et48Lwgs0dd0xk+LkBX5BoD6nykIN9KRuXBGqDNtZihZRDyeIqSOS
         IlaEnku2WC7XuSXe95sg5YqrRBWs/9OtA/9L3c78HNnQk11FRqTNrDdYXxRrzYpBnQla
         MkCY82xLgPWeHLxiG4HtAKXrS3VVyB/tOLbHyNoZc/Cga8GlHpEymxXmJd4eDSlClHH6
         8Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782264350; x=1782869150;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HCRbCpnbD8iw8+YXonGk3G4egkfXoMc79Jv1896LIk=;
        b=Sm2XewuBUXelLl5zw8aNESUCEGMES0tQXBc28fvWStHxQ+2gfgOqd3OIBFGtunOpbC
         hJB7Z72HtuaW1G/uyfeCpqqzLTdo6FmGOTh38xXlf3z9/dgF0UcIkt6+DZZQIeR+R7Cb
         rexfaHhELfsNs2vNRP1kMWkNDPyYKj1tsNrd+j+1SKkau1bZfkh6wr5fYZu7VPome9P8
         QCGL+eN8VcfX+huiIC8aIq6nMRWr8PXZ9TspxNYbCzL2+sRmrxl/SW0mB//h+6MItEMw
         IRp2kpSbNsws4UKLdADWmAldqu2Oyz8iuK1vdK0iVD4Ej32B+xv2jHy53E5+2TeL+u7a
         qEyw==
X-Gm-Message-State: AOJu0YxYg2OXtMFvDsIQn2EpMxMDR186ALxBsE7qwCTOZQUtjRqTFn2L
	0HqOh6uiiCDFjRXPpSu0e3FJpE4uoZ1ZlOyksCI1ZfENXlY8Hupwc9SN
X-Gm-Gg: AfdE7cmq2jgtHUsVleUSo+bOi5upf25E4jubX+d3MAzJzaQcN8UdSkBZCZpMD8th2gN
	SDVt5q7LmLGA58y07wjAL7x2FeV+eNG1XqldU0237uraQkJKqyk08xC599iY1gRU7t81cUqxIlY
	EU+7qaNbA4vsFjayqgbPokc2v2L669a5bKLEzFljEuyGD5ZBfIR/cOmB74ExB3N6DNDFLXv1P5O
	2ghIyomaz6zZjquc0zaI8/6qNQ9Qb8dEqB9LSU9hRFYu0TD+iqr9lmjpl+gOjbnI/bN6dqEwxI7
	1rUDdCLCgZB5QnCwklQ4mBY65+4VATP2Huf9eh4uOeoAQqxzUG8bImfbRjCOFHZs9/a60hTnea3
	siobPov03ksUhv4UHZmEF94SETh9EzNgmaySjOShe8pQyMxY98XHyNBfR6qUinLVC0MxyQzh/Z6
	ChtIjkowAlmIK5DlY=
X-Received: by 2002:a17:902:d4c2:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2c7e15265aemr12562995ad.29.1782264350114;
        Tue, 23 Jun 2026 18:25:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af310sm121860795ad.2.2026.06.23.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 18:25:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <aimOVomL2RzYt2J4@google.com>
Date: Wed, 24 Jun 2026 06:48:02 +0530
Message-ID: <qzlwwxbp.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Compile tested only at this point, but I now have a series of ~17 patches to yield:
> <..>
> It'll probably take me a few days/weeks, but I'll try get a series posted before
> the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> support landed in 7.3.
>

Hello Sean,

I have addressed the comments which we discussed in v3. Kindly let me
know if you want me to post v4 or otherwise I was thinking once you post
your base patches (to take natural alignment into account, which we
discussed here [1]), then I can rebase my changes on top of that series.

[1]: https://lore.kernel.org/linuxppc-dev/aimOVomL2RzYt2J4@google.com/

Thanks for your help on this!

-ritesh

