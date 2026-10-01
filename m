Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA443EF0A0
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872489; cv=none; b=CZMW6jfP4T4MBRNaYnCUSutMn2Z8AtCN3q+9KmIUA99Wz0NRg8TGnMruMpLVf82ooPywar8fOAKBqomc9ZrGFNGKGqHUk8CTDFgV4f+O1go34g9HBt3RHW3K+AD5GkFDQ3VtwSk90uwUzthORcW1NfTdQgH5g6r7s7blRbyAvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872489; c=relaxed/simple;
	bh=ub7p2AvtgHDlyXYYb3wPWRrL+7fdxwouzEwE+TG4swI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfMCkMFIGG/qBXi6EyUVTywgANSoQXNjHCNknWWM4WjJPIDR49MQOI+Z2dLSBtZYaDBKTvmdEb4H4vYpESVRs/TSvyuokzqEFYN2dW5cJ1Mjcm7WrWe3eeWKDd6yfQswf3poTQreEge7C1V7ZTHO0HOaen/DGvT6BkN7/gi6r3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UhtsiPWJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UhtsiPWJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so3644205e9.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790872486; x=1791477286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2XF3uKaHdG+8ZvOmrRUZMGcZKEjSK/xxMzPJWRXrSow=;
        b=UhtsiPWJEm9uMR5fJOjbFVJpL4QANCdD69enIVccLPU37LftDi3l0z8KvvOX2BiMPL
         hr27OneYrKoA2Cvu+pFnsDxxXQXdtYDEf0xLYcjBjpDiIVeAbC/MebSU8oNAbAKHUWfe
         miWmlz9FTMJ8k/wrVVdjCUMjh3l7MBiqJItSkTgDsO4a99oa2WzjB6Dg4n08nZ5eAYY+
         KBwhriik+6toiFLs4zrsNcZ1rHl+B8vj/XJKz/9kvuSLW28bCbRkkPKmqhAQjv9eU2lw
         GlbttyPj4BiE9RYCOuHzjgeDfHhGBT1eMkrvmQR6Jnc0e3Gsr9IUXgUuAGo1TjwpwkNh
         oQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872486; x=1791477286;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2XF3uKaHdG+8ZvOmrRUZMGcZKEjSK/xxMzPJWRXrSow=;
        b=wcU7UMy+AetY1chCSN/teRYHHuuJ4PCoSwtneTj9LdyabIcVNeQ5Xwzn5kev8lngLq
         aInKj61h3gU9CpLSRBB29b5uG1U8NOovdbhsWSSJtPD8YvMRU3jNcMx6+tTmz1HVYfrt
         TuByLLjvZOyj3V+enZ9hbildDHyzFrNmN8sEfKxy9dA41+TCtXKOVE0DVLxcxO5sViZf
         uHXFD9b/hSYBJLVsttdFNVI4ZWfwR+WeGri1NzxAJ8dnBlrj3dt85H+IaYU+UwQf9fNr
         Qg/l1R/gLz0C9BFwYwzilYgmSjEnYLb+UVF7F7vHwISH0wnID9pu/Mp+hCFoKMNSDwyT
         4f7w==
X-Forwarded-Encrypted: i=1; AKwUvBx84VGU9EJOqdmAcvtO28fjfmn/5PLyiiduqu8F/fn9lh6/xVCBYsWFhnZrviSld3iAUKI=@vger.kernel.org
X-Gm-Message-State: AFuF++m2vPIxRae2y/QL2WhITh78hPzZAjHH/5HJAaV1ontP8AF7rf+A
	d/5AD8G9Pf/iTgjnbfJ5rOAW/U0UTwINhTVZ9BPgCx70Gg3zKw5GrSMAtDkomCCl+rs=
X-Gm-Gg: AYBFou0+Ww+avGWQ4MfbApagrUq05D0+I1f7MT4CzRamZVK8f6koZs1BoyYP6OtpH8I
	7HzKYsQ2QjhCnvb1O2tn0YYME+UjRXlOjUOzD+IgeDpzf3WbmNDcymlCzvRmStj8D/ZU8bk+Mrp
	GnoT9NxBxI3WFZXIL6aifbqaKcw9DZaFT7HPhmg5dJ/fIL+x2QMh7fmmq1/ZSTZpkc3hBDMCf/C
	pmG7KJrxatz2q+/bCtAo38SkevVI6Q58AQyWMbkRG9FeNXS/T39AowPKyDYlqOL45p6IExzxzIK
	f2X4lCTAGLb5z+r/zMYqj+JbQUiPwkjMyNTJghpGTIHvpC43Wr/CWsyCkpnKfxSaSHsQNMcp0Kc
	SauvUdhaaJRcxTO2lgil0fbHHJmR/1rhL5t2IpktFrfK1GIDsnX3Pf9s+oSBmzGXhfkeG3mVY9a
	9XWxO0YYQPz3MvZ6SmzJu7+zEclFWW0LW3eaZs5C8Qo8kfw45MOVUte6AXufHsuDpGy0748h+bE
	LVnkOBiZMNyWsX+jGUUaJM=
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a02755fd8bmr2940795e9.9.1790872485794;
        Thu, 01 Oct 2026 09:34:45 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f1c2sm38621205e9.2.2026.10.01.09.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 09:34:45 -0700 (PDT)
Message-ID: <ca464aaf-1935-42ed-b486-4f4cb84ecd2a@suse.com>
Date: Thu, 1 Oct 2026 19:34:43 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Gao, Chao" <chao.gao@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-8-chao.gao@intel.com>
 <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <763dcf982570e0ffcc69a6e1922fd2cc266539aa.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1.10.26 г. 2:54 ч., Edgecombe, Rick P wrote:
> On Tue, 2026-09-29 at 22:38 -0700, Chao Gao wrote:
>> +	/*
>> +	 * TDX_FIELD_CPUID_CONFIG_LEAVES and TDX_FIELD_CPUID_CONFIG_VALUES
>> +	 * give the field ID of each array's first element. The remaining
>> +	 * elements follow consecutively, in the order they appear in the
>> +	 * structure.
>> +	 */
>> +	for (i = 0; i < td_conf->num_cpuid_config; i++) {
>> +		ret = read_sys_metadata_field(TDX_FIELD_CPUID_CONFIG_LEAVES + i,
>> +					      &td_conf->cpuid_config_leaves[i]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Each config has two u64s of CPUID values. */
>> +		for (j = 0; j < 2; j++) {
>> +			ret = read_sys_metadata_field(
>> +				TDX_FIELD_CPUID_CONFIG_VALUES + i * 2 + j,
>> +				&td_conf->cpuid_config_values[i][j]);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> The comments are not strictly required, but probably fit into turning this thing
> into "hand coding". I think it's a nice addition. I wonder if we should make the
> "i * 2 + j" a bit clearer though?
> 
> I'm not against leaving it as is for now. It helps that it doesn't morph too
> much from the code getting moved. But I think the above falls a bit short of
> hand coded quality.

Perhaps this code warrants open coding? The code will end up looking 
like config_values[i][0] ... config_values[i][1] ....
