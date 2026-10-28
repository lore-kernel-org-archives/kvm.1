Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191769;
	b=cJf1vfw6vrkUZusYIpOgAS09t1laU3oChkv12Er5HDPlTULVPcZp4W36pX5IAipBOM87
	 JDSpZT1Y0SrnTm2cF/hwKrIDiX20s5fncDpeNWBN+H43/wloDVO4xs23XQlmgPVLkrtX4
	 IIXlru+OUHgyDD4ut1xWOXKzEVTmkXVz22KWU6S6rnb8wzSmtgdPZCjmeJKhufV+Xbqqd
	 Kd1Gyf2nrh5GagfiTvES1YzNt35vLl6ny8D6PsNcDy2WegnBPFX+VcGRHw6Xxg3Zrnk8I
	 TJPEgATeTtUJy/j26lIFmKOhNMiKcvySJnwDp2Ola2CptTCZEfyGlEq03NiDgv0idAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YK41smP7QE9oJovUtzzAvla6GYf/L/dPjCC5nmsqru8=;
	b=b+vV0KVBLrYdyRL7qF7ClaYw5rh3FGVBYOW5SFJ5a8ug/6fUwZGh5+B2Mayem9ZsITQf
	 s6wtSNKuU/4hj0uV0+vEaS8G2db5D9dlekbhqNDs9I3Xnq+M08MRq7pC7qfUYVgXvoPBr
	 LoB0wDkSPhaokwjFlw9Urg4shEzI7GeOYP10kmOx/4ELmv/1VbzAP03qEY8Gti5+XDSDu
	 MWDW8r9ep9R1JrYVYy0kDMr/p02B+NmVMi0/mTn0YRrTuMwUoQlP2HGF/3hlfmxDPpRhP
	 Q/hzwvv7JcpcU0mn0ehBs0vOlkqJ7rXs0KKl5TkEtyLINYLN4FaAdhR3mMAlrddlmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="FLQpX/Gw";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B50606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B50606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FLQpX/Gw
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so7009665e9.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793191767; x=1793796567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YK41smP7QE9oJovUtzzAvla6GYf/L/dPjCC5nmsqru8=;
        b=FLQpX/GwzpRrDYRTS6RpKgN2/3dRI2UnPBn4fKVsGUen0LVkYXdl/gK8EYqK2I+Ln8
         LuNwdIlL7Lir/k6W2TfuVpHjlaHwKUbLSFDdC/zGqI71PAFfdLKcqzWcX2edU6j5LPpd
         4elQBgzGkv1DqGu2sEzu1Z7b79+q602tWFB9NeyvlcdIilmTmgRIu3C61eO8TkMtYg1k
         +XMz7JCujuRyy1iO2+Ksto6L2pNahwlZTkuIcuQntdDklA22Zyqa3b8I/hTNAC5Ki5UH
         PF+mYW9i2l7K1i4FOfbfMtFAwbFsKhstUp7b/viC6FFYcFJlNjxlpw7pyHzvlUbsbH73
         zt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191767; x=1793796567;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YK41smP7QE9oJovUtzzAvla6GYf/L/dPjCC5nmsqru8=;
        b=zvAZkQDi2SZEXjM8RP9a2tEAMltfzBzpOSYYoBzr0C1wp58D2CNmtMnDrjhG0d4RLd
         pEvJHLEurgiMJZ1VfqVZRVjD53TLOmZEN228Zn5GHuYInP2sbYnd8ON2YbpFhzsqGVbt
         xW9qIiP/D+UH0dkfTc4Y2FLwsd6P6vuV9Me+DFIsbVaRoN9ldHcG8vWwwPlOA4qN15SB
         DaL+WHpGxNy1RZaNPcMoemVhpIyvi3UUYztjDh4OHDZHmNKnySgtyORfh45iBxq399sD
         uLJx8xyvkbNuJF50j1Xcx2aw6JlvFLOPnIJ7XE20KWwsa4DngpA+Wv6kMJsilbmc5Qxx
         jj7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwPY9mQSa0qBL8wAxLdIXS4v+cXZ1URdJQsHS7thmPUaSpMQrJVhnLGtlxIyeyr9rLmMZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJzoOM9z+GdhQZWbn9LItHQF92voq7YFpLw1MuEfN+YdRoOMU2
	liMKCA8uULaGchbl+eQMv8Pj7lgfeRxTN7l6wCOdcIQL5axO0Wi1AAwe0jblx2OJenA=
X-Gm-Gg: AYBFou0+tQoNn+Wn/hlNuOEUstoMFdmfjw7j5faezKaM5YNv6eDIxN9e4OMuaOqq5Cp
	ezUuhBn9OMWlp9k4HHAvdQ/FhYKpgMSAY22C91tU48VOL+1ygeGrYWwx+ugOiWlEiXXjtE3Ya//
	sKmtQ5rXeVovgF/OGBvieQGYPXLeBKAiZi9VC3ueBpH0u/dI712m7r648+rnWSGgEYTFNa9ByuN
	1kgvoRWpvQnQa/xJTajeVML83Niqv3Y9VHqrDwg6MJO7MUhSePway1SU7kIK155u+0qnh3Xr/Hj
	GtZrR4HfgIRxUA491rEoo8PqP3VpMMcnKEYaKTT5GR/Mzqie/dfvOFh6R3p7MWnerCxn3z6DdYF
	bJNThf1PasYJdMulfZtuVNZz9QBhO9weiuGdBzzCzHZl6FAgUkM4q+5CCLU24JhfVBCzjD182nw
	68xjPz04PMcbAlvr3+jkfkw4/iIGluOSBHxzOuYh8j0NjcQNH7jZvc9bch60BU/g441ZTkaby2f
	yehNdIEp+nDVfwuKxbvoKKYD4fCK7JDrzMYQhbPSCoCifJfo3rBdYzZqRdryBzZ4WBb1v/YAtFi
	kY52iEA2SyL1wCKmSbfY+O0IoovxJniLIOp3ejoY2fLrhQ8jpSaVNA==
X-Received: by 2002:a05:600c:a00f:b0:4a1:9c71:9f17 with SMTP id 5b1f17b1804b1-4a996d873a9mr37324205e9.9.1793191767028;
        Wed, 28 Oct 2026 05:49:27 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a969e61f9bsm28159215e9.2.2026.10.28.05.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:49:26 -0700 (PDT)
Message-ID: <8ab1834a-c544-4a2c-8fcc-cf7b00b4f4d2@suse.com>
Date: Wed, 28 Oct 2026 14:49:25 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] KVM: TDX: Report only KVM-allowed CPUID bits in
 KVM_TDX_CAPABILITIES
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
 <20261028081658.1228484-4-binbin.wu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261028081658.1228484-4-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.10.26 г. 10:16 ч., Binbin Wu wrote:
> Filter the directly configurable CPUID bits reported through
> KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
> denylist-based filtering.
> 
> The TDX module reports the CPUID bits that the VMM can directly configure
> for a TD, but KVM must not advertise bits that it doesn't support, as
> blindly exposing a feature that clobbers host state can corrupt the host.
> The existing denylist, which clears only TSX and WAITPKG, can't account
> for such features introduced by future TDX modules.
> 
> Add tdx_get_cpuid_cfg_mask() to compute the mask of directly configurable
> bits that KVM allows for a given CPUID register, and apply it to every
> CPUID entry reported through KVM_TDX_CAPABILITIES.  The mask combines
> feature bits, taken from tdx_cpu_cfg_caps[], with non-feature bits, which
> are identified by function, index, and register.
> 
> Treat CPUID.0x1.{EAX,EBX}, CPUID.{0x4,0x18,0x1F}, and CPUID.0x80000008.EAX
> as fully allowed, as these registers enumerate non-feature information,
> e.g. family/model/stepping, brand index, CLFLUSH line size, APIC ID,
> cache/TLB/topology properties, and address sizes.  Allow the reserved bits
> in them as well.  Though there's no architectural guarantee, given what
> these registers enumerate, the reserved bits are expected to be used to
> extend the existing information rather than to enumerate new features.
> 
> Also allow CPUID.0x24.0.EBX[7:0] (AVX10 version), which the TDX module
> reports as directly configurable when AVX10 is supported, even though the
> CPUID virtualization table in the "Intel TDX Module ABI Definitions"
> currently lists it as not configurable.  The table is expected to be
> corrected.
> 
> As a result, directly configurable bits that aren't in the allowlist,
> including bits introduced by future TDX modules, aren't advertised to
> userspace until KVM explicitly opts in.
> 
> Note, this is an ABI change, as some bits that were previously reported as
> configurable no longer are.  However, the semantics of
> KVM_TDX_CAPABILITIES are unchanged: KVM already filtered unsupported bits
> out of KVM_TDX_CAPABILITIES, albeit via a denylist, and the set of
> reported bits already varies with the TDX module and KVM versions, i.e.
> userspace can't assume a fixed set.
> 
> The change isn't expected to break userspace or guests:
>   - Userspace that honors KVM_TDX_CAPABILITIES simply stops setting the
>     dropped bits, and KVM_TDX_INIT_VM still succeeds.
>   - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>     still allowed.
>   - The dropped features are either obsolete or unsupported by KVM, and in
>     the latter case, a guest relying on them would already have run into
>     problems.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
