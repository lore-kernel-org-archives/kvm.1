Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3823CF960
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853009; cv=none; b=A6YNs9BZMDDjNPCgZo3asm6KJFxSXy0UMibGmT/yO/88EVjePzmfyw+Jd1TiIMa+qzkucascWOvqdjzCKe1fgQh4NQtf8cQPkIo0TtpKYmBrimA7Lz1X3SlPziHduTZabpnZuXKipKAqF2CNAMqYiVHPMsAKh+DVo4n2rTqK3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853009; c=relaxed/simple;
	bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=t68OuqN6jyIn/WG9ClONe5kPW3CguH7zg8OCzLUedW2yQZKSuG9Jgb+nAankqp25fth7d54JUOdbNXIOvQYPN+m6hsmpf0kx1yfbgsv6fkbl7jtN6Cp5WKFeLZPSTwWVkIVKgNupJK8QcBbsEi5jL6W160YIXnlOUT7YzJz/eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlWfLUIq; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWfLUIq"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9b895ee02so3069378a34.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853007; x=1783457807; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
        b=OlWfLUIqXBJuECnBrubNj70YYTjxV+TG+dFSqAAtRBJ+WttAgJko4w3kPjixO/4AHy
         eG4Jiqp2uT7XYR6GVLJ0B0YXVzci2487DwK4S8DlYgTlRNw3GuqY6Wb7Bf9HciZEQF0n
         JEKElNYXgwxtvqshZ+TKvhE69FIJ6LpY4NX9tdej1vDZJXRt6ejwSS7ITNpJAj68dmXh
         TVE808NwA7fALCWBzNiDUMwjZelsE6aeedTu4uLPTyiKQcQLLDVmgPxkBq+iaKSqhtYN
         dtiNEiWbCrDQYUvI1muy2UPCTCDXGn0KAQ0yICyOGSQ+zcw8RI08W0h4x1f1Yt5XK0nD
         xe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853007; x=1783457807;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
        b=jGa/SollgEw9+hDoLzqZYHqMSANgorbn1nUnyoEYZjhuX0fUyYhBfUm2jGVclcOwGB
         tmECqFlnuwDuAUzqdqpMgkTUR4tyvbFIYM+31ZOH7pjGIaP4QpJuBVOif9Mu07ydfSNc
         NLCyKXl1Y6vwmTYVvbcS9YEvXuOtc+O1rlwXi53SP5MyBpNZrZwHRuJDLfAhVHvgSuQv
         8M/+WxsAcajMF94Ybte07cU4kGexKiaOZFZ5C1Sas3LKG3f5kYTR2nPqVRgdpmXccGeY
         qyBSyPnpKyJXMbx7TASq0otLSJ+ZLbSqN8rZRS7+ziDAR8CB9BOsYwLMw5R7mT6A1q9D
         bmqw==
X-Forwarded-Encrypted: i=1; AFNElJ8BJSlVSAV8EacCe9OYFUGgp8tQEbnxBQ+IvorLJOYnfopj1zLQJQN1fJdXW+4AyXEneGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83i4x0NBnShy2QuLtoOEPrEhIw+K63ibElf6yyOuX1yns+hRv
	IvpR3GxJ/Ea5BSGuNj2U7bzMxAi7mOKCVZH2Qjc4dpZF8X928dzGfqBt
X-Gm-Gg: AfdE7ckEUeiYmFWDItc/lEM27EGVYn94GsdKG+JcNTpW4gCfBu3Qeq5qEyZNQoBqKKp
	tooSYQeT24JiB7sINIOr3XP8dblXTc8At7iVE94LZh/IilvJ7Oo2ZRkLdbS4rqhIYzKSWHdzO0+
	x8zIUQ4ju5t2UOHuxT1VFZsuS1y5uwBilvHP3p4j2WrXXY/3KwfcLUjyok/YRr8lDF/51pBBcRx
	RGEAeYBnC780tjihqM2zzCF82PD01BT7JqX/NPbRdMvcf4P/gPrYUzI/kF+JUtvvWL5R5SlAFa7
	3FaO2s1bGBgcezaVlKcKv/EbwXzMKraTfarHk7UarAsZtEcmS6cUaUPAzwpOxVP35I+jkfGm/FH
	vB04dYjz98qvp+99kL1QsvoYXwoefX12wOH3aUVM9vDJh7mI00wvwDKwiaFOCGOj9pyQN1rLkU+
	jG3taKNc4wi1wt6ed44X/JTP236LiLW6TlReCmoWLBfmL6zX3WwmakH6rw8SB8bfH3b38A9AKLl
	rqPsQ==
X-Received: by 2002:a05:6830:264b:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7e9fc096ea7mr1417099a34.31.1782853007039;
        Tue, 30 Jun 2026 13:56:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec307edesm3163887a34.21.2026.06.30.13.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 13:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 13:56:45 -0700
Message-Id: <DJMON7ZNGXAE.1VLWYJBVWKWD3@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Aaron Lewis" <aaronlewis@google.com>, <peterz@infradead.org>,
 <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
 <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
 <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
 <james.clark@linaro.org>, <seanjc@google.com>, <dmatlack@google.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
X-Mailer: aerc
References: <20260630141152.3757722-1-aaronlewis@google.com>
In-Reply-To: <20260630141152.3757722-1-aaronlewis@google.com>

On Tue Jun 30, 2026 at 7:11 AM PDT, Aaron Lewis wrote:
> I am proposing this patch as a simple way of turning BpfTrace into an
> instrumented profiler. This approach has come in handy for me more than
> once, so I felt like it could be useful for others as well.
>
> I am not entirely sure where something like this should live in the
> kernel tree, so I took a chance and put it in
> "tools/bpftrace/instrumented_profiler". I am not attached to this
> location, so please feel free to recommend a better place for it to live
> if this doesn't seem appropriate.

Nice work, but, sorry, this kind of tools don't belong in the kernel tree.
'tools' directory is for things that kernel itself needs to build or debug.
'tools/perf' is the only true exception.
