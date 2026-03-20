Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B43D1711
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043548; cv=none; b=W5m6Z2xfzhv6LDCLi8Z4hRS+lLVNr/hAgjzEVCwGXsRc06OxV41rILxyH7haybgJ9QuxeOV+YRHXvRaQ/n6l2ROT85OMf6zETOhU4biiB8DtEg9NpJTseIDZNZEZ4rFS2XIpcW2mLfjjoAKVM/GgLBCo4HIJZ0ajcocRcGvnKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043548; c=relaxed/simple;
	bh=4rFPhnCxXsuIxmCPfSBZHsCKHrt0FHTGDppz6mMoiY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzbABNKzuFDdZU+W2oxn9eJDHtYudvPr/NqJv5acFtTigdUygHw2Iu3pg2pR6FYiX37EB/apMxZZnh74pbsr3mSivdnnYP42xKyL5gTmxO8wOjJ+Gi2kKh/9Mfyi1KBVgjNAmMgOruWpiXnYWkoifwkMnikjY98DSS62VNoU+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPinX/5H; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPinX/5H"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso844733a91.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774043546; x=1774648346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbJPLOlgxB0/11AE3CtlvCBdGPlx6ENuIB66JCuPM4U=;
        b=jPinX/5HPm01vR9XrtGshj4gpStf82mUve1BCEi0JkSCzcMmfLGmOjVqTgDFJ7mAZp
         mV9fODvXZYc3WkUIIMJvmOZ9jXIhUmYeeNSCBIQapsvrJ/PpkX77ztBdIH1PH5HeTINh
         l854EASx0ocE/cgU23a8bjhWtxKi44YDIi3nLKOhv1h4+6q7BOaVaVrHunJ7RGQpkWzr
         SXogMT2qhdvpOclNyWyzGIRUnYUh0BeSoD2fJzK4RvnOD+t7SSQQgjzU1yID2evh+yKu
         YQ0FdtHvj1RX/MCPj9EJ6wdbhd9Ehl/AUZ5mKDgbc4aZm2N5fLoUfMmCk6WGre9lpEeJ
         +92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774043546; x=1774648346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbJPLOlgxB0/11AE3CtlvCBdGPlx6ENuIB66JCuPM4U=;
        b=Z5K3A2JWeCCN4Ic0R/39mVE8bcC5YTImnDybbH6+JaSwOiAV3WvOFRiR5ewQlBlhl5
         qJ9R8s+VakleH2qgG+K95LswbEuo7JWXYugcfvTdRpU1b1LJhlAhUPUtENCW9hwQRcQO
         qfBdpXteklz8kudqn5B3hSl9kjxjw3sdGhcGy+aExYfqobBM0h8817ETqmoqtucJjs0H
         7kivLA4O1bfyRmTyDhIVmlNpvRyMGLZcIPTAyFlk7voqDsP/FH4hsvy+a3jDVioRwdVU
         aClVLk0qk9tUKTHKjnnrxITN7zj64yD4Rjw0DbhsLlj9n3NWxjSVTNMjKD+xsRqeSSn9
         qGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXen/SQlol4A7S2dd7sSXASfK+1a/TIU4YSaVd3U0LFEkcojNvMmw07ScmVhxEbcZV+Zv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrmt0xv94QQw8qyFwBeErul1oJcn/BbSb8oUehm3xqIQ7f60H9
	4kujDNwk0WvBrCOq9tmRCS9UcxqSm6hI16hrPJvYEgRtOrzstdkzI7QQVYSds6r9c30=
X-Gm-Gg: ATEYQzwGVRTE7RdfdQU5/UxKTJfbNNbkpD9UivlR+gOCGv5s+Dwx8DMzMkR9dWrkPlO
	fx8jonxjM8D2wwPk8hu6k4z4WTFxvTJLLcfQpCjK4incSp1Lfb2RpOzGtS169OwUuSCpwHNpn3i
	ceEDLe2m2B8v73pYvusczCPchUK6AK36Rs2C2ul/lTbj0snf/2pL8Y6li7bGGqJ7e2nGOJwQD4D
	QzR2/lkvkVW6uwArl1dHZ+h65tGibLDpsI6S3uKHQ7q5oqPpO2vi5qAWSVPqBFQpR681RsvKeYP
	kh4K+e/5bA4I6KNhpK1hqW6Qn6SFXk1YRIy6bH7yci2LspHqFwmvP2ddmXdlZalS5nZGU4tQvAE
	+6C4vU3s/DMH30QD52EBawKbF8GPwqk4bgCnkTW2sHadNHYlrOt3Bdv9RUueYrvngSjrV9OD+iN
	2UZwrU0JQq5qP8pPTvuAeweFneAv+VhfL2jdjsdz1tgQxsxs973UDbP2lakxJgmuVUZQJs
X-Received: by 2002:a05:6300:210b:b0:398:71c6:e8fd with SMTP id adf61e73a8af0-39bcec38a75mr3936020637.59.1774043546196;
        Fri, 20 Mar 2026 14:52:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a7ff47csm2486650a12.6.2026.03.20.14.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:52:25 -0700 (PDT)
Message-ID: <419cc31f-3651-4c45-a8ca-942a0cdd5506@linaro.org>
Date: Fri, 20 Mar 2026 14:52:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 6/6] monitor: Remove 'monitor/hmp-target.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Max Filippov
 <jcmvbkbc@gmail.com>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> The "monitor/hmp-target.h" header doesn't contain any
> target-specific declarations anymore. Merge it with
> "monitor/hmp.h", its target-agnostic counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   MAINTAINERS                   |  2 +-
>   include/monitor/hmp-target.h  | 42 -----------------------------------
>   include/monitor/hmp.h         | 12 ++++++++++
>   hw/i386/sgx-stub.c            |  1 -
>   hw/i386/sgx.c                 |  1 -
>   monitor/hmp-cmds.c            |  1 -
>   monitor/hmp-target.c          |  1 -
>   monitor/hmp.c                 |  1 -
>   stubs/target-monitor-defs.c   |  2 +-
>   target/i386/cpu-apic.c        |  1 -
>   target/i386/monitor.c         |  1 -
>   target/i386/sev-system-stub.c |  1 -
>   target/i386/sev.c             |  1 -
>   target/m68k/monitor.c         |  1 -
>   target/ppc/monitor.c          |  2 --
>   target/riscv/monitor.c        |  1 -
>   target/sh4/monitor.c          |  1 -
>   target/sparc/monitor.c        |  1 -
>   target/xtensa/monitor.c       |  1 -
>   19 files changed, 14 insertions(+), 60 deletions(-)
>   delete mode 100644 include/monitor/hmp-target.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
