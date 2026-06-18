Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C2E06EF
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813022; cv=none; b=Ky8nbDFWXJHGS7IZnROTnc8XCR6HJ28azrKKHhd/9NBXa6KB2gTxJpyMIH7dPiwepb71QnAlCfEoxIcfwgFR59JTzQ1Ym+Z6Q6J7rR91TF7xz0DKYzBGdlCJY1Gek1hwDDH59huOHWHg5XZcqOt8zVuENIvMjXCDQP5HPkReo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813022; c=relaxed/simple;
	bh=pBk9kGJqbXRSBiX8wQep4HoR3YvnXTOqulYjM3xplJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPaDh94lfoRGzAkX8qu0ZIAY1d0bbFCFM5sKEuJ6XEu0AEg5a9P71CSIQElwgCYHgHqbJVAlTHZubeeeh36hqvtQwSmy8Ui8FZp69eovfiMBZ+dVs2rCq2J5tC4+3shfCkhw/pFzWzLhBLeUBipknhzZjSzKSIUayVBfwZVeGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu3CxoO+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu3CxoO+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a76757e5so8825465e9.2
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781813020; x=1782417820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBk9kGJqbXRSBiX8wQep4HoR3YvnXTOqulYjM3xplJU=;
        b=Lu3CxoO+CtbcHE9O0K1SZnk19gpNRoX9BYyfi+2dCmqE89jZ96ohr+Ru8m7GFiDOS1
         +HWTcmXAKZdh++lcv2R8bpLS6YTkmZLNfNdkef8s6boi3Y+DpIwbcfNH73qt0gRKZ8zB
         DgNwY3wmLH9s7mnMP6BsyjXWmut+ogxo4gppqzUhUW0Ngrk6M/r1XmV6P+9TDPaJfApe
         9RwRA0VmOMBtC9dwjlGvXk9y6AqqdyMetG8awL5Yd5zf8SvJTaTX2/j7kKDPGRsUcDoJ
         Ua5sOJMdX1eDLNKO4VuqgP32mcHRc0HKzwFeGa6L1iDQ/IhYHw99bPVJknz0p5gQ8kIF
         3U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813020; x=1782417820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBk9kGJqbXRSBiX8wQep4HoR3YvnXTOqulYjM3xplJU=;
        b=fNEF6dVGNZ7LmJ8AVVpWFHrtsxxNvI5egUjETjPPu2ipt/G1XBLy/Y0tl3buQ7kMJs
         9wNwKIGTf/fjf8fFLj3L7W9kQofLW0k4ffCadO4r4zuk9D7nc4oNXo5N6GpM2MM7NxmZ
         o/xhbsnYkloCNzLFPlQi11lKVIvnNVuuKkcEv8HWBbJTybOU11rPYesBVSg9UtakOCqc
         /EiJBTtx0uhotp/XnHE2+ZhDdzMcS5NWA6mHMWpnPJTL4rM9uhK/t6AFkVtOsVcMzKWz
         TRMPSEQ+WJ+/DNOxUlGAEWuGykTuvR6NQ3XXnRZg5FzMXoMic3f0beaYdrINoDvwDbNu
         6iVg==
X-Forwarded-Encrypted: i=1; AFNElJ96is+bw93s5Z1dOJgTlZN/AlYIk0fObz8fQIFxbE673XPufBJuO1J7JueHHPgMYA42O9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JZYnNLQ7gbZlxHQaZcFIcDEgTU5LKyoQ36aTiQGwjjX5pdDo
	yznOcHdnI8c6RPLHfpWPxtHr6IlJCdr40iJeNAy/nUk9ckeZ47ZFshuy
X-Gm-Gg: AfdE7ckzxj5emrMigfMNzeY6Yq0UIinBzdHgiUeLNsv1/ZcRTAOeCClfjbSoLLW36LG
	JTUr/ajvbrvxX+dQICYkYZ1pWd4HNUCWE0/XCVac9hW/lDoC+xfRd0OAw5m8L+Tb3j+dXA7IQv8
	C/FvLXaVazssdSwnIQamgdvpXCI13ZcQnqH9VqSLd1g5EE7+kghiAR9+5PHxb+8rLvour0kjFAz
	y5rs8CkB+OT40nZmxkCkONe1zmRPSYCuCAVionE3b1aXp9pO2JkiA5HX9nfiXdM75voy6kTArMw
	rfVvNBqzO9/w/wKLdP+xhg+KRIAuoXV/ExlBiw+jcM3za5hKhiYdulGnSka9QjtPlCgskWvCvzO
	zysIKd09Grb0ID1bcpvOlTthQnEtD2p2kWSYtYS2cqJreUdrxJNMPopj9P7TeN/PB2wri4sF3aM
	9d9xFqPEiW9GycJypanwYjKXPDiQW3bdRtJ+cRPeynBqgrQA==
X-Received: by 2002:a05:600c:4fce:b0:492:1e36:bb04 with SMTP id 5b1f17b1804b1-4923f6ad553mr18204725e9.37.1781813019397;
        Thu, 18 Jun 2026 13:03:39 -0700 (PDT)
Received: from [192.168.10.21] ([39.40.61.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b67a248sm1487602f8f.24.2026.06.18.13.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:03:39 -0700 (PDT)
Message-ID: <60ef7ff6-0aa7-47eb-bcf4-76606ec016da@gmail.com>
Date: Fri, 19 Jun 2026 01:03:32 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/include/linux/types.h: add ulong typedef for musl
 compatibility
To: pbonzini@redhat.com
Cc: seanjc@google.com, shuah@kernel.org, me@brighamcampbell.com,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20260531144934.403888-3-hisamshar@gmail.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <20260531144934.403888-3-hisamshar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/26 19:49, Hisam Mehboob wrote:
> Building KVM selftests with musl libc fails across multiple files
> (e.g. memslot_perf_test.c, cpuid_test.c) with 'ulong' undeclared.

Gentle ping. Could I get some feedback on this patch?

Thanks,
Hisam
