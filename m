Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832D2E7F20
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491242; cv=none; b=kIzI54HUcJFe/PtJcXd7aQ8uqSZUiPiw4SqddUcEUgzfKKO32i71KyR3gf1EBmI/Hsb+LwuC8HCmU3/oH11XZQK2OYD1qVg0TvCILd4fCSk+xsT5SciimQKm0gO+sqrYAPi9jNalXYveFJHxshEs31NtYteUfQXv2m0PDDUnhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491242; c=relaxed/simple;
	bh=gmGXAC4PypRESWZQ5v2CoL8ngI9l7uKVPQm3uxl3K/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEb8m16XstfpctUoT/pIjf3JqC8YxRsCbgdFlEpYYb3Roq8HMlmSBGytNoRLWhCbiIsGu+up4pY4Y45nrjUltFSDoShRMMuJgSVs0x0irJNw4JgdOyR77nohK5/SVA7zy2cknnhsuW2QCkq9qv9LVQsHOUXc//YIKp5wakw6p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdYSRHMR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdYSRHMR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso6605525ad.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786491241; x=1787096041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0eStAZ6SsJfA6QA9D9uuJRZ4Drf8kSStCDfosExh3Hg=;
        b=hdYSRHMRBM8gbxT4xaxWVd7AvqCsupj2rYqju6wih/tQJBEpHeCRHoKIoeYkw4g4tn
         4D76XmrQAM2eTBOzvr95tTXJKibDgiyJJ8LjYEPDFDea6cNxz6lF30OdTA5ExIITYLZM
         YX/q/0fJ87DtX7aEokrT/A8fLKiqInUbWNCiJke9kp4+xocX01LjxL0yw41hP9kE83Dz
         xC8NaNY38UtT7aOAt6Q9hm/kmcAHjUBg5Js1uZhMvPCaPHMvwtAceGo9sThyy5eTjpyo
         JhrY50h13xLROd1c40L7cy+LsWRhCQVWhsBXUB45tM8VDSnpXh3wg+RyA2hb2dRyIo7C
         7P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786491241; x=1787096041;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eStAZ6SsJfA6QA9D9uuJRZ4Drf8kSStCDfosExh3Hg=;
        b=h/HODz0UGTkrnBNmDn4cGXyie74Uyg5faQP9KWZTCu2ppJsfyOOwKegAHpQ+bhwyw3
         SoFZKWMSt0nBwv9/wuGBQcdYe7gvTNrZS1bxInMbFQDCgXMLniX1hUCTdU5H8KmSoq68
         uwRpKdO3/FQBOHkOuKvIF+hM1yfTCVm9yIcXKqHDE+pFAWEncUduYUJNwBOLmvPY8KAt
         hexSnVZetWpQu3OgEEUQFVmYEsFpAIolL5eXGcuohoAlR7jtYSswBcQdQPY+gxb6VJ6t
         NbqcFJ393miqJZViGUdRdMkm5tQ7L5q+8gsp4+H89BvS8cVPa+XwUaPXzbMSkukzHX+5
         L0JQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqtfoh6WLzTTt4Of0BPQUZMyfVapVGtpqgTV/tmHe2qF99hW1WMC4H5AT08tbZMhWGRKZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9CPneidnZddMyVkTxV6F3cU8MdlXljZyYxdPTni7y3FjpbE7
	sLuGHDmGKEy/WVlP2DP0Xpbzx2NovDv1yEwjUKpMFtPqZNtLhbORv1Diws0E1O4npmY=
X-Gm-Gg: AR+sD13Y3NdD+DTkyYHgo8V/Ald+IzJFnFimFReblAWaX6OSjuehKpt/HL0+3y6udSx
	5KqUUMVQpgZxMaHIAuMCNYCf48Q8MSxAi2tDIwm5GL7Fw51CJ8vAoECuPH1dx+FTGY52Y+yu5Rf
	TjhSWF48T3l7U+hbBhG0T+lCTV6+5JA8aHUHif5QVtU/OI+4pK7+Npxc+gfL9CioI1eS2KIsIDd
	lJ9uQHx5lKGDVriPtyQvF1/HGcsw3d6TMSY3rWZ8qQUp4p56A8U2vWrOxP98ixzJNyJw8syvY8k
	6Ru7jEDmlmdTmoWQC/SlO+7a9LxSYXjr36x3phRDq8vIgmz3HJkjK91BrHi0dO3pKQpHYESil56
	Lo3Q5BLXWMybPxKIQOS0mPB51Cyw7mT4r4Ji0qj6pahuMABvPKw8KqJNd2yoIEGVNVgGz/AGPEt
	zGNxE5ZlRDnwoAddsP2JmdLG10cJn+5e2BNCQ6QcvHw6/04BhF7vcTBPYHwKbDMafT+alA84OMW
	mNLBgc5Vvr9M+/YSJRAP+Rvt4Krz4chcusNZGc=
X-Received: by 2002:a17:902:ea0b:b0:2cc:90aa:8787 with SMTP id d9443c01a7336-2d3452da5d8mr13405955ad.6.1786491240755;
        Tue, 11 Aug 2026 16:34:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef024esm12928355ad.10.2026.08.11.16.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 16:33:59 -0700 (PDT)
Message-ID: <eb53043c-0379-4fe7-953d-e311a2eff827@linaro.org>
Date: Tue, 11 Aug 2026 16:33:57 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/cpu: Slightly sanitize CPU API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/26 11:34, Philippe Mathieu-Daudé wrote:
> API cleanups, mostly removing system-specific code out of
> cpu-common.c. Code churn renaming functions, in the hope
> to make things a bit simpler to understand.
> 
> Small patch set extracted from a series clarifying CPU /
> accel synchronization, itself a preliminary work to introduce
> split acceleration, eventually.
> 
> Philippe Mathieu-Daudé (8):
>    hw/cpu: Correct CPU_GET_CLASS() comment
>    hw/cpu: Include missing 'qemu/accel.h' header
>    hw/cpu: Move internal declarations to new 'cpu-internal.h' header
>    hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
>    hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
>    hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
>    hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
>    hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
