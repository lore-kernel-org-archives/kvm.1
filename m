Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254189;
	b=kWWHcUD75lgr/Qe4Ju+WDbka6h6ws71+VEJ1OyvvimWc9Z0PE8Tn0Y72tx0GOUJz4Ftl
	 /H1R5CwM2VEh+aSocmVhyLsm8hpGFoDXyM+NKhugAdEa4Dwo+5XJEwQymaf5h/OlXpW6P
	 YRQgTQV2p/Sj9fBuN96li1nrjk+8Rn+N09AlkLCE6Ds0wLi1bHsdoXtFKGf5YjIEv/Yq+
	 3/7qx/ydkpPV5tBntpdWOhO14Or5g55NSoafATzbmXw3UzwykdyrZYCYCmzhX7AoAhqnU
	 kXNUfHy2DfdOtM9jyKn5tt96D9fHAMSyE2HZz69u56IwBFeCFphIcRKEbDR6Yi/p61Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UQsWADyvy0RizFTfpkH5RXXR2lFPEQeFdYrL6SMlC7U=;
	b=fUonAd3cHnm1rbRJAMSfnb0KOx369o/m/cCJsXJoC4D5+gcx+BKAwLzRwO84J8OLN5FZ
	 msuMtg4QbJx2n/HsaXQ2QVZ+SotiqShdb5BEUDG4oy1Ay/X3jV/YW64zapTviO5Zj62Ww
	 pApz4VdlqtazHV40bX1ArvoOLcuNtY7w2ktKJl4HDNqNcKRxQYdMpVGlEHRBdiWaDo0Uj
	 WOM0+YtToPEfOG6jhJRBKBt9PBOFnEomf6LLjxqjEYmBTJoK81iQzJaCbMaM58BiHkVPM
	 1bsR56Z6H6MWbsPXtp/X4hIA6YYlJmr0SoLBAnx62DPrziYBfP27aeEwEoJFOPpoR1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WSBziwoS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E21B606A32A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E21B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WSBziwoS
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso13146676d6.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 11:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254188; cv=none;
        d=google.com; s=arc-20260327;
        b=KGwFpPwB09H8ANxBqIsAhqotfgIDoGkgvDx0aA0ij1iGOuwfIFBS7YyV3v/QAG3zrt
         Sdhgh/8FtgH4ehP/YlPYu8X/uLGOaxOasJluWn80jW12Ze7+6A9ucZh0GGfyuUgNrwI6
         8e1wzZbO3EylozEOErDEObi4uoEumlujutxJ7GK7ESs1Hn9PiVByDdndqaN4hAnc4S10
         gpj677jIQatno/s6/ejGn0phkcSyGkvFcLVbSbmTwvQTajmj3QDTdGWymnwnhj0EpGu0
         s/ZtwMO8xboT+b3Nn1acg0f6W4WHX/xYVBSi84LLschud0xaZ0pMq0+A8YX3XGqZboVJ
         T8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UQsWADyvy0RizFTfpkH5RXXR2lFPEQeFdYrL6SMlC7U=;
        fh=kjrx83hwuAVz/7BxYC8XZCooQ9ucAujGIrQEF6bfQjM=;
        b=lZPX5AWweOWZBaytDCT350D9hsDXBVQTCgiJgiAFxaVSjLwDCEf/8QbiPN2MPMPBLW
         ILD1AuH/ww3f6BXR3QVvioZIU13MlP0PywrcTClyCAJn2iTQ8sIKXSb/uZJ/I549k636
         XyU43thjrPJlU1r7IhWWJA6gXYWIfCyWG78M9vHcRwj4CZYLhYypRvU3K4VoP5NNgVdd
         tzd3mNlhf5VxATdeOoGzrozCM24kKxCUvsk5XTzVvHzUORd6QIxt3PdaOOyU0SOPRf4+
         GW+NojF77Fi/gohWnqw2MUlMB6BcV5mnk/SUDAkfAOmY/RhzYIOZeZAJaUh06EswXkzz
         6PnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794254188; x=1794858988; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQsWADyvy0RizFTfpkH5RXXR2lFPEQeFdYrL6SMlC7U=;
        b=WSBziwoS8flyI5lQi9ahqDcBfOHtzvGVIpeip6fPNlY+Ge2i9VvGHvTk0SjAmMj6WY
         oy8dx9L6dC+9n99kVoiMoAcQJkha2qzfsdf6GmScQeX4Zt6VC4fMOxh+SuUz/Oovgi4T
         gPTNsc+sseOYkbHCKfQXFAl8Z/EBKmED1IBwpfFZeIhlON5MJwgCVmw0V5UkQ00ZKlR8
         xiiuDkZs+tv2LGVT+Fo9hBVASg8xUxoubEQcuuHQRwBD+UZ7YCtWrtU7vh77QHMZz3bo
         U8OowvQTEodhREy5dxVZh7swpTiUFcsF83upkmLtzweXaVRT2ZKpTzmLNh09nL4tt/2s
         2PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254188; x=1794858988;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQsWADyvy0RizFTfpkH5RXXR2lFPEQeFdYrL6SMlC7U=;
        b=FSPsMYF+lxrDlnjO0qOQ/ghtubeZbRexMdCPZkIheC0h7yEyCwBNiWnnDCkujfkaud
         oq75ACp2KqhL0M1Cbd7Luiv4fuvfKkWdlpdm3T7xJd6uEq6RPYnIMPaOQFVXftC/VHav
         iha2O9GTbGp9pH8/fhd4PpUHj18zm6k7dk82+tkK/56LvgOJBSs3LkTtALeIFNLQw1yA
         I+z7ftbQB8cAcyD+i9fAgAac1IK8LPefizppgQW5xdzvNA7Plyn9tS78VRt/46mlPtGh
         9uL1CwXdQOpOW00/AsepST9krE4P/+3+gSUJ8Niy262FKlABovyvAXkoZ3fhOhBkrW+H
         MsOg==
X-Forwarded-Encrypted: i=1; AL+hErHRZh1wMmYXWTCNWZVJGP0xFTIo5QGn7TB0v4u8g7Fnocd/vZnCplTI3SdiclIw1lbA75k=@vger.kernel.org
X-Gm-Message-State: APuU4Z99arA1Y1UhiXZX8p9RZEFbYbkyrf6ihkGW8p+b3jm6OZj132rK
	T0F6w3dLTG7U/r+XcKJSJ6Y/BHijSn0E/OZGETTge7LxRCc+pRvu/l3AFtK/SWSulsD689AWxOs
	xg+REmwALXLyyOLg7EtquDfQxO0tjC4aBr2/Lz5uw
X-Gm-Gg: AYBFou0ud5Zkf4lLJ8Viv9O43S39sUDRB/jCwDRwpkXP1F1vuhdH1Yn0K14JSoLH4sD
	hRs5mSX4rojNAhTOG2kF186xCcovlCdV2lmY8OBGtMvahblUqjCMkmqgA0D84dmLrkSmrgX2z0f
	ikqjbbiXJeQpA48+/OzQi0lOKIHaMv5g7V5DRxC6nCrGTN8aJOjoHgpotB52h0YPFym+Ld1mfEp
	rbQCaMelJJwSlyJogJt9UKmd/4/NvVJZLB/8Gtr63DCxaG5JFIZUIzCKUpo7gK0AqvFRq7jXZed
	RlgNARwWR+PTvbIImuLQL5o/cKSXt7LfefizsER4441D9ZQQoT+3febvQT7HK3/nxiorK67HOyY
	EVvlS2QlUPsasca7MUuivqd2NPSulLFSpADA68mIyfh//cbnim31Jyx9EQyBr9fCKu7xELS5qN/
	3aqsJ7iJnpWRsvKjliVXulqHQCB4A5A5aMRQsQ/zFbrfH8
X-Received: by 2002:a05:6214:1d21:b0:91e:9664:4e2b with SMTP id
 6a1803df08f44-91eef7a3c83mr11733606d6.7.1794254187357; Mon, 09 Nov 2026
 11:56:27 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:56:26 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-11-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-11-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:56:26 -0800
X-Gm-Features: AclHuK-1WjXMX68h1oPEz4A9GDozdAxxlHkeQ9giBYSNuXqnEZTuJ6BoJAHDbqQ
Message-ID: <CAEvNRgFTor8fZzRRMMv5cXvxu7NCiKEOpbh77HSHGEdRRbt9EA@mail.gmail.com>
Subject: Re: [PATCH v16 11/20] KVM: selftests: Require guest_memfd for TDX VMs
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> Force guest_memfd for TDX VMs.
>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d42e201eba76..b73a7bfe8531 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -494,7 +494,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
>  static bool is_guest_memfd_required(struct vm_shape shape)
>  {
>  #ifdef __x86_64__
> -	return shape.type == KVM_X86_SNP_VM;
> +	return shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM;
>  #else
>  	return false;
>  #endif
>
> --
> 2.56.0.455.g6c5a503b38-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
