Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB1425CF7
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688217; cv=none; b=m2OQAVZBoDqP4K4WgbmDGTIo2sLz6KfRpT9w9kEY2x4eQyMJp/EC59fyT66ogXbB+q+zBkdm7euPVgC6pT9RoZtGH73dc19Ndab2wLNZBqsGu+gb52WmwcaOosyWLa1902MVVJQcr5sdunpzGoCFIrbZLh6otOVFiIhXjyDRZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688217; c=relaxed/simple;
	bh=CO4tiLKQD5QnRcNIQMjbFM6AT0IQrnvInDknfRcOgbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lql6cw+y49ts4+gowXTF1ajdgFnn10KjWldojpgGgTZs1/SW4/NHtWPiBXOiUMKKjefDR8Q+cwG30FrqCyub8HdBOrlNgBFDaEjdKZHlqZZMZH4cIvOjFriWz1TlbPtHS65dabYoWIox99vts20bWZaJsktcVJ043VzKdTGBswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N7Q/0VJR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N7Q/0VJR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47d70879764so598885f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783688214; x=1784293014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LcGLQLoAqQZpxfr8pEbjumPwaEE0/AjrmTN2lQZXaO8=;
        b=N7Q/0VJR+I4dlccPLQDxPDKGrNDdTvU+UrJeTer7/7WBnFGuUzVyVUT0uE5PwTI5gs
         tEZoklMDxscECi3gG4WLkO0Ufd4CJ4XxX+NxEob+RrhlTqxAf+oPRkXj/ya+uA3rjEJ6
         WAD8eVCELc/5IYAcEaLt6S4Oldor0xIbZ80s/fT8anSc1uz8Sh/b33/YfsceLuo1Eoix
         fEuvPkCS8ymqKbsxs5VHw1OAh2Zoi/Q1o2LKoEtFpsmursulMq71bjqAkkx2SouEE/WC
         dw5n9LOuNI7HuY6Mx6HCdSsk8XRt2dEq2x7UnfjL+HPMkcL/ZJ+H/LPRtEnVgE9FE0kQ
         dE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688214; x=1784293014;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LcGLQLoAqQZpxfr8pEbjumPwaEE0/AjrmTN2lQZXaO8=;
        b=W1wO3fup8dhAkz6L0zFdLu2tRedZg2kvL6RUJZC33e6U6z4R9ZBOwMvlH4ft1NA2Bu
         yICeAJeScqbBRXjmVG+ZsUqai10HUiJLZoZPx/CuWpU8vmPbZB+I4rIOjQro5Xi0VTHo
         BayTJeYxpMrHW9hGvELbb4F4ClRqPWRMlrNdtkpuiVfomklTfSLbgjc8aod01xKKUrQZ
         RVuUG+8de2CyA53XrzPqIKfcQXIO+wCgqMbDY8WyMJsEkPWZM+oSI2tClGWdQpVDLWpB
         ohE12aPX8P8xl43Ykc+ZamwhjM0wTWHtzAvbx2LPKgP7CREJgWkDse7108ekjMbWtjf/
         iYkg==
X-Forwarded-Encrypted: i=1; AHgh+Rrb96kmm1CJpM/jpFOLPVeN/QDIFms16CNkX0yL0y4aAiOariZ2WCQC24hAk00j+9/mF5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gkGSW/WZdG7LNa+U0dEHIRGeZIt+wsRhIxAsXu/1eJzruLIi
	4M68W8rrFVrvZabLvw/rYuDAaIcJKPbaLORCGpXljWjPDZ9mHGUNkpzXoXj8OpmYwrM=
X-Gm-Gg: AfdE7clqtuxMJzNrvLKuSG507lBFg/YdWJnx+LHMuTUj1+rfDvGxybA7Wo3Y7KObtjQ
	orHkH73H8g/VsLM4SObZOvtSqsRh8ii3R+1qZnByeFDJifXEBgwjFfP1/sEBHlMDP3+ttZr3Mhj
	UA59Ad2mjPaopLfzukO7U1PtIjUPAcBDgDy+MfQtOMlxQ68C/HxRJInCC0O50RQ0rGplKcAkRF0
	666S5yBhzg3mB91Cba3N6cgmAyeD7yAVthq5rITpYCx3LbmvBPn4b19QP0YzbYbDH/S07ZTRUoc
	bCt7lQR/siI5yHlbDZbcEjEVGKKlYq3cGGn7YZvlHEn2I/VTLDAjv/rduu6iUkfd8v5U91JsuM5
	Q1GlsjNXaQlPd70/wLnPuAueXJ0RD118bB8XQ0afytJceTZjNr/k1UlbVMk22giUPkjRxQwxCiY
	HvwDGA/FLS6XKqLnZ7Q2cS9qaH+Q==
X-Received: by 2002:a05:6000:2911:b0:46f:9d18:bd3c with SMTP id ffacd0b85a97d-47df07a959bmr13458692f8f.12.1783688214568;
        Fri, 10 Jul 2026 05:56:54 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f2465ae8bsm5921129f8f.36.2026.07.10.05.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 05:56:54 -0700 (PDT)
Message-ID: <b7f92bcf-c36f-4ec1-868d-b88a14fc7ec2@suse.com>
Date: Fri, 10 Jul 2026 15:56:52 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] KVM: x86: Move supported EFER bits to kvm_caps
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706195413.1966458-1-yosry@kernel.org>
 <20260706195413.1966458-7-yosry@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260706195413.1966458-7-yosry@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/26 22:54, Yosry Ahmed wrote:
> Supported EFER bits naturally fits into kvm_caps because it needs to be
> recomputed during vendor init (e.g. to account for EFER.SVME being
> allowed/disallowed based on nested being enabled/disabled).
> 
> Move efer_supported_bits into kvm_caps as supported_efer_bits (for
> naming consistency), and reinitialize it at the beginning of
> kvm_setup_efer_caps(), removing the need to clear unsupported bits in
> vendor code (e.g. EFER.SVME).
> 
> As the bitmask is now globally visible as part of kvm_caps, there's
> little use for helpers to enable/disable specific bits, so drop them and
> open-code updates to kvm_caps.supported_efer_bits.
> 
> No functional change intended.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

<snip>
