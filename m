Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F733CFF55
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369415; cv=none; b=Qf9EcJw5/7iGu195EG5G/B8xQXEmmBxjd6Dr5AqXIbCz54m6e8LpOOxv9Y0/7S52AS6lQuggKJkerZ/9/0veEIs/RW4z168DupiwiS6tY4+YwNnZgeQ0nwV3mk2eTOYtrc6yOKqGeNVq0/6Xh9/isx0hGa29p41ARfygV28Gvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369415; c=relaxed/simple;
	bh=8Rfk7gIPEuIIX2PIjkrJ4msFNT/ja2cu5nvMt9DMmmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGpWChrjXAwKyEhvwxk8xBAhmxufj3xdXCmQ3ec4w0kde4tWqYH0KlSkp7ihw/57RpWTmHyJd7hYw3jQdcya1k7HShoqgGXohBbWVtKY10Ts9Qj0CkajecP1WSgCVfz9oXrCfGKFZ6WCE8szj+x+KAKyxjazGZSx2z35gxxDfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMfju6Gz; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMfju6Gz"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2687966c88.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777369414; x=1777974214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+2aQrESKSPjXIMgAlPSq2BTaZgqO5ydTBn6YvPyGsg=;
        b=eMfju6GzWQTFgzfwahFC+fZwObRlrvjOwzwa4hDWscxLbvALYh0n9Ujz3tJv4SBSX8
         WAzgdY0IpAy9AHZJCL1UzCc7ZXBiAu2ESz2HRroCxaneaJkkKI+QSwtVOHKRIwmzpCGY
         9cHiAYASJiAmS4rN9FQMRwvASpCwhaMNKT6B28ykOn+fT7VMHhgdNF5a9E1CEEiuoB9O
         xooJsR5GL7dWbFqhpfkPzTXjNxgN0GY2zKaQ9ncaJoOJWiixO53YLYkLoCNBpmVG5mxZ
         Z8UA67vIazPk7MeIR615PyCXJg7EXqiR+yvZos9H9p4SEZ5R/RfWGkmGDi+uipJ97x3a
         vjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369414; x=1777974214;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+2aQrESKSPjXIMgAlPSq2BTaZgqO5ydTBn6YvPyGsg=;
        b=lt+g9nzqZj9QNn5r+JdUImEhNb09sr+pMj+nFd4lI8rLLlx3Tlt7wCrTRfmeY1H0pN
         2OsElr9QvGDTO6he9gWho5KtzPm54m/vEpIe2vWxS8ZNpnaQOFq8lRCz8nTDH3e3dMWw
         3beesbzgW61vC7O3iMfZQpOlpcTblSRms5PVkfG75yPRR46me2Qc14ZHkiHnxiCzwGv9
         GDMAUrWFUajL+2LufRD7kZZ4fvfZ0dYLiuRZJYU1LKU1KewkUN8s5+FIbFBxAZn0oOdr
         q7ecDOMf+RESHNH7WUWv53tO3YVndQIJBA64SShaCPRZNT+fjGVvyWE5HF8iGsKHo30x
         uIUA==
X-Forwarded-Encrypted: i=1; AFNElJ9E2ioihKQAoVFnjx5uTaKo+9bpxKP5suEHwIR/yzNxIfvYtK+6b6RFYmIFNyXwtMjRWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YwYJcQKXvWphMczpayU72PvHVnN86xLf5dzUAwxQmDwvEHur
	V2uCArRNkcx4HemDb9siRITjz07df2FiTKieh5dI3D3V9iG60x3Nhitc
X-Gm-Gg: AeBDietcNdZy3X2n/tuf6Hz8cBSazI7xohHy2tdwQ5RzNuR3wNsfGLGXL/BBoKVBizP
	Y7A5cBy9yFvWoXDMelpqDUqbF7gI3uHjIAHc1qsfEHGYJqZS8L6eZ/uPgB33Qx24HTZHfh8RGWP
	nJ1WxEgixHxSkk+n/u8yto4fdAD/YQd6KSDwU58hlKwZLLL3p0yxIwSc64knn2s8BZfRPrkEvEi
	dIsrGXCOyJ9miiTFLc5xwtAsuo/63jBpv3RWcOj59XAPOeEctR2CZygpjj4O7gqggw+GlKSWl6I
	NbK8Jjv+sUPDs3P3fxhvIR9fzWkwaYG8FTtxCFQ7ax4lTa/B+oqv44s4rcI9j3h11KmrkrS8HRg
	On2Pvgx895QGY70Ai6QRHZ3jlq2mIWQVxr0fMu7znsZ9S8G4tNKZYR02yJKrKvVOUHwTYb8dk6J
	hmKfUd7JhJt+heioG3pjNGpKyyeS9Cm/Mco/zW
X-Received: by 2002:a05:7022:621:b0:119:e56b:957b with SMTP id a92af1059eb24-12ddd90e40amr1289308c88.0.1777369413478;
        Tue, 28 Apr 2026 02:43:33 -0700 (PDT)
Received: from [198.18.0.1] ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9be1f9sm1811919c88.15.2026.04.28.02.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:43:33 -0700 (PDT)
Message-ID: <4b66c381-09c5-496e-b95e-100d1ba20dc5@gmail.com>
Date: Tue, 28 Apr 2026 17:43:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] hw/core: Make CPU topology enumeration
 arch-agnostic
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Yongwei Ma <yongwei.ma@intel.com>
References: <20241101083331.340178-1-zhao1.liu@intel.com>
 <20241101083331.340178-3-zhao1.liu@intel.com>
From: EwanHai <ewandevelop@gmail.com>
Content-Language: en-US
In-Reply-To: <20241101083331.340178-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apologies for the noise, please ignore my previous reply, the corporate mailer
collapsed all the newlines. Resending in plain text below.

Zhao Liu wrote on 11/1/24 4:33 PM:
> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.
> 
> To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
> CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
> socket.
> 
> Also, enumerate additional topology levels for non-i386 arches, and add
> a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
> with compatibility requirement of arch-specific cache topology models.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

...


> @@ -373,17 +373,17 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>      unsigned long level, base_level, next_level;
>      uint32_t num_threads_next_level, offset_next_level;
>  
> -    assert(count <= CPU_TOPO_LEVEL_PACKAGE);
> +    assert(count <= CPU_TOPOLOGY_LEVEL_SOCKET);
>  

Hi Zhao,

While booting Linux under TCG QEMU (-kernel + rootfs) with a CPU model that
enables cpuid_0x1f (e.g. Shijidadao-v2), I hit this assert: when the guest
queries CPUID.1F with a topology level greater than CPU_TOPOLOGY_LEVEL_SOCKET,
QEMU aborts. Under KVM the path isn't reached (CPUID is served from
KVM_SET_CPUID2), so this is TCG-only, which is probably why it hadn't been
caught earlier.

I'm not sure the assert is necessary: the code that follows already handles
the "input level out of range" case correctly. find_next_bit() returns SOCKET
once the bitmap is exhausted, the loop breaks with level = INVALID, and the
encoding path below produces the SDM-defined invalid-domain response (EAX=0,
EBX=0, ECX = count | INVALID_type, EDX = apic_id).

Per Intel SDM, CPUID Leaf 1FH does not constrain the input ECX value, so guest
software is free to query any sub-leaf index. Did the assert intentionally
protect an invariant I'm missing, or is it a leftover defensive check?

For reference, the KVM kernel side (arch/x86/kvm/cpuid.c kvm_cpuid()) has
explicitly handled out-of-range 0x1F subleaves this way since 2019:
    } else {
        *eax = *ebx = *ecx = *edx = 0;
        /*
         * When leaf 0BH or 1FH is defined, CL is pass-through
         * and EDX is always the x2APIC ID, even for undefined
         * subleaves. ...
         */
        if (function == 0xb || function == 0x1f) {
            entry = kvm_find_cpuid_entry_index(vcpu, function, 1);
            if (entry) {
                *ecx = index & 0xff;
                *edx = entry->edx;
            }
        }
    }
introduced in commit 43561123ab37 ("kvm: x86: Improve emulation of CPUID leaves
0BH and 1FH"). So KVM-accelerated guests already see the SDM-compliant response;
only TCG aborts.

Thanks,
Ewan


>      /*
>       * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
> -     * The search starts from bit 0 (CPU_TOPO_LEVEL_SMT).
> +     * The search starts from bit 0 (CPU_TOPOLOGY_LEVEL_THREAD).
>       */
> -    level = CPU_TOPO_LEVEL_SMT;
> +    level = CPU_TOPOLOGY_LEVEL_THREAD;
>      base_level = level;
>      for (int i = 0; i <= count; i++) {
>          level = find_next_bit(env->avail_cpu_topo,
> -                              CPU_TOPO_LEVEL_PACKAGE,
> +                              CPU_TOPOLOGY_LEVEL_SOCKET,
>                                base_level);
>  
>          /*
> @@ -391,20 +391,20 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>           * and it just encodes the invalid level (all fields are 0)
>           * into the last subleaf of 0x1f.
>           */
> -        if (level == CPU_TOPO_LEVEL_PACKAGE) {
> -            level = CPU_TOPO_LEVEL_INVALID;
> +        if (level == CPU_TOPOLOGY_LEVEL_SOCKET) {
> +            level = CPU_TOPOLOGY_LEVEL_INVALID;
>              break;
>          }
>          /* Search the next level. */
>          base_level = level + 1;
>      }
>  
> -    if (level == CPU_TOPO_LEVEL_INVALID) {
> +    if (level == CPU_TOPOLOGY_LEVEL_INVALID) {
>          num_threads_next_level = 0;
>          offset_next_level = 0;
>      } else {
>          next_level = find_next_bit(env->avail_cpu_topo,
> -                                   CPU_TOPO_LEVEL_PACKAGE,
> +                                   CPU_TOPOLOGY_LEVEL_SOCKET,
>                                     level + 1);
>          num_threads_next_level = num_threads_by_topo_level(topo_info,
>                                                             next_level);
...

