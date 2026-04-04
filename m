Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FC285066
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316064; cv=none; b=genWihz3bepbJ9BApKCeffpEziYLQoIPtcdD00PLulJPGWHzqTDOZv+a3+ksC9B/aewTsBfvtPSEg+D8m2W7eX8MIZp66KLXfdALOAh9qjgfJ7voqA8p0c9B7iCppYvTXCcgOKkOENYZs2s4sBhGsVP40jB1cj8Hs9lTWD3AF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316064; c=relaxed/simple;
	bh=bwi3fwqRL2gMkBWbXUNgaSztWecB9cnkr2OnSeMSIqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqlenGHuW7rTgVv8kuxT1o0TpYPfd5nc5YxLCVNo3tRHWSNAXjO/Ja2dGd8U9cF+OfxN1zQyi4pnldZNmsox7Jtu+VMvROPxmIto1zYymEReZ3vDBbUt+2rvzmK4TfL1ZNkExbHGCXg5E1ltdRJ9G4hJJ9Yz3InX6iJbHuzMY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGanoOHp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGanoOHp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a041eae5so7407695e9.1
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316061; x=1775920861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=OGanoOHp1Zebwnc8FiqdpONklWtKx06Rr45qyxbCocloiS8fxa8iA2zxTmNm/Qu7Wf
         VN8M6Pr7OfHLyuyvXYEZ4EZ68bhyGem1zY6KrDcE7g7S6r26KeAiwEZo9b06n9Jtp6Rv
         BxxulVNC0YiKuI4s99+yQfYr2J7LNeSXHag3RDmeZlTJzrmp3L/ZfskOtQKnOr0mUmjP
         mk3iras8E6HQWO5Yj4VkGJcvDk8Qc3Bm1dACNRiz6mw/BXRt07cv/hkWsv0Fo+XMUyaf
         7u954wAEsv9AOISAchZoazK0ZpZI7/a939lfNU4++L4MkxWVyI7PFJ5OiaxNu7q+Mo8f
         s19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316061; x=1775920861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=Ay+GAH227MRQCwJfDVHx51eKfRp3B3KRzzqoug8S2BX8srC0RTTrnChY/DMKZGlgY0
         8svcSum6aJX/rG6GxXIIjJmUpEX29MT28RCyWK+MkUKR3I3z0J6pfjXuQolMvtiOHhb8
         chzZ0fVgOs2EAVPHLW2bM6vqv6xq9dM+bdLD+nsYKC73yNsgQzlu9fPWsWHzTeMtjKaJ
         aT9Bz0BUSua9p25oqKbVwcWpDR1jxFSd7Q28lC6nEsHhJPecvBVjiVD8nlNNFfBIZ4nC
         yH3HewzZ3mgDa/Qo4UDrMczZ8f1rYURiCh/1wJ/ajflYoCfy34kG1t6WxSmXKjXILzun
         lGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiWMMQygihwFwAcMOzejrZQP0g7l6yL3X840UuFcDuIHa3UpgWYb7ntSxW9GBUGPEbpT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5BUVM0RTOvN+MX4XBLfXVB3Lexoi2zOb23ero5tSCdViqfIu
	BRjgUC2arCJ7VtB+4Son5UrJdx5tuHgiFPCv5WS1Kkml0mtD9jtWi9MN
X-Gm-Gg: AeBDieseK5gGFJCpN7tsYFpzgbr55mXZm7fcTOj1ehmegSAI1z8WcZ/917a7qDPZGy4
	zCniUYMFCuhgHlj2Vgy0OB41tU+40QAWSOaztl8ndn0awHeKCd3ZZTU37TujcqoAq4KrO/ZtyzL
	DGrjOoImvKyAyzqWy6SMmBo8WTJUxAj881L+DBOm87SKrh96N6mo8l8zrEy9/q/eRvp9+YPkY6/
	ZVliSqLsbnUlI/O8n1YkdH9EfHhjyQzq+Sa44VnIs+uFRlpQYChyKlEWCdiK09sVIq3d6/c3mMI
	vd5VxLEjGpdbDmpBbl+JuYwBkD4w6tMl54uwX92EiRSFtqCKKUZURgeBg5GMtxGH8zZPLld9NFM
	cxue0j3bl7oCNI/lmY90zyF0hTaKorJt4vLbI4cIMEnOZYICXqTfyTCZrF2jW0uJVteIrY+TwIO
	5WW4VWEbavGiZBFclHZGDbHqIgeKccPA==
X-Received: by 2002:a05:600c:4650:b0:488:9e54:94c8 with SMTP id 5b1f17b1804b1-4889e5496acmr44565465e9.31.1775316061052;
        Sat, 04 Apr 2026 08:21:01 -0700 (PDT)
Received: from pumpkin ([31.55.121.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm25182762f8f.31.2026.04.04.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:21:00 -0700 (PDT)
Date: Sat, 4 Apr 2026 16:20:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov
 <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, Sean
 Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260404162059.34ca90df@pumpkin>
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2026 17:30:32 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> v9:
> - Use global variables for BHB loop counters instead of ALTERNATIVE-based
>   approach. (Dave & others)
> - Use 32-bit registers (%eax/%ecx) for loop counters, loaded via movzbl
>   from 8-bit globals. 8-bit registers (e.g. %ah in the inner loop) caused
>   performance regression on certain CPUs due to partial-register stalls. (David Laight)
> - Let BPF save/restore %rax/%rcx as in the original implementation, since
>   it is the only caller that needs these registers preserved across the
>   BHB clearing sequence.

That is as dangerous as hell...
Does BPF even save %rcx - I'm sure I checked that a long time ago
and found it didn't.
(I'm mostly AFK over Easter and can't check.)
A least there should be a blood great big comment that BPF calls this code
and only saves specific registers.
But given the number of mispredicted branches and other pipeline stalls
in this code a couple of register saves to stack are unlikely to make
any difference.

	David

