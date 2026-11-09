Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255376;
	b=CY/OX4JqmNktoLRT0CHwO16fMTKkRvGT2OPCPwhNH3+K1dgVAM8UbnJTGTxd3MOz7Til
	 0t6Op80OnNegV5cZ+uPUonbvb2Rr4AuTiZUif0bZUqy/hPB/WGipdfPWlELBUU2gwmxCN
	 sEgiv34Brmf0ZhYRzD/u8hSggA4zYjkQqEU0xIq+DFGTniW6stuh1Pt447lR+vtpi+zae
	 y1Xp9cmXwKTZsufMT2SbC9kN9GNsNoRWTNmLqCzCUrvrHL22BeqW0OsLhMUC5nR8umks3
	 OBgV/zwd7VJrR0CpWuGAacPp8kqWnr6RzKksZQNciz5RBJ2wsTESBZGHYG3EcjUWCSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=2C2a0rTZmMb1b8kfl4y39LCIMoVYqOlFcBQYRTbTISM=;
	b=Oq6NBxDkXh1YBAuxnnHrjFvOyxOfIc1SIoM+EwVIXDHxBo9OQjzgmc7pysigCcFmf1od
	 060tg98rLqRuxuz3ODGezMxXTZKJ+BOFMnc7GgYJDwEBAFRnZoY90Jj9PeFk4YmxBmEx7
	 1NfGraR63Csl0DzBH20tMxzXK+o7YZzuDFfyn247nhZkXisMiCeP1ySTclTjxDqaf31pQ
	 B5uBjtJK7M41Y7g5hAbJbSOpmCNpL8Biv7H/PCu579nBaZWZK2x2o1WrGpyP10AOgnbAX
	 OXacba2BO9J5vRDFeZv7UE7So0EaDO57+RK5J91kg/ImThiReAN5RFqGAed4ZF1wPuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GytkJLah;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D6606A33C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3D6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GytkJLah
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53639b8903bso16401841cf.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255375; cv=none;
        d=google.com; s=arc-20260327;
        b=Zyz2OFK0I6bXk3pVmnXFe1QkUeUH/2xWSI5MQPAkw+xvnNurHVaPdPzTazt9FuXHGE
         nFA4GaWAl5ZuW1YH0zmnmjV1c7ed34TDns7ATqUBUO0Ea4JqTzBKygYHHaV0Du6478aN
         glx2bzC7OF+0J1G2pg2Q8Xm9j9BE/A9stfKD8dzpEmoTJUFMlDPv6TuMldqFJmWdvvZW
         iz57hzT+HXrdedMZgY3OrDrrdpjXpp6onzC9Kt3MA2jVq+FPBb9djQv+Uhgg2yzyMD+K
         bJdBS1Tlcntv8RTv5GZEkLZNQWQ7abbMjhJ6p3aPinGmE8DWcDFCsl3gl3HDNC55E7Ix
         IBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2C2a0rTZmMb1b8kfl4y39LCIMoVYqOlFcBQYRTbTISM=;
        fh=s/28lCNJsJiIcOieL/E3wbodHWASQamVihtkExFanDQ=;
        b=b1WS2yTQhejUO09C72q525QMft3YV/T9WABE2Phy2pYLfUGFYnVivf0WUDYGeEHs1e
         nwyiWmyDs3TpY9AES9Yu/t1hwjHgciW9gY2lmSTAdkUtYfLl73K3tdxq3uT2MvvkFpvL
         oBMX+7TfHT0qlT/cm7Hfm4a6RCVFFn67TwRfuAIAwhlCzNGvAOv9bVoV6i+X4DU56G8k
         zDO7pKDQHh6BLEXf2kfcPX8xXRbZF/gf/ebhgLvsDFuKBOryl9SgZBhj2kKOIxKfAale
         lXI4Buu7OvwS2RnVQujlDn6vdz1YTHpp4cV/6ZXO0/TgQsAaTPLarIIVqPOOPwM9z84V
         LRYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794255375; x=1794860175; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C2a0rTZmMb1b8kfl4y39LCIMoVYqOlFcBQYRTbTISM=;
        b=GytkJLahaC5gSknC2BeSaYjuS5OWPS9Q9faIFwuTOzFH91EGiGs85BgjFUJTt7Eo1k
         D8CmJqn431qFGnTi0GyFc3ATFK2ttZuCbLbe/3KL11Umhp1wO/COoFsseNvtoyIsQqyn
         Zae02ZVx3+j6flUP2At7E7YiGNc19tk8PZtWLEDAPiZ5VdBg/e8jfArsWaeTXlG705xs
         0GdW24ngyMXP9qi/6z+xXenxH563KQe7yhP+3/gRRkr88AHiRxrgnmm29tPrbs2sdLqT
         +yCEBMMmg8OjGyf3ljZFT0B5Z2rQEUOXoGzYU9eMpH6fMqpZZIjaoFj+ruOaUAsI/N7q
         PVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255375; x=1794860175;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2C2a0rTZmMb1b8kfl4y39LCIMoVYqOlFcBQYRTbTISM=;
        b=HRs+9sjcCzj7K4zNlljmO5onm23T6CGLJb/kMBHc10TN+6wCnfCNw51wFYHj7TeOVd
         ga/pGWmOzLY6B4FknVelN3kILCHd3rVTTHd1RSQ9AWwhYzYNqOWf07puGcagzDszMl1o
         Z6hkW7LBiwt3zf6Hk+NXLHVnwO1ewjjhlAOG3mNm3LBvIGz+UjLIV52I8zJv5FbKBhKQ
         tkyDB1nrVHUwHJOqJIA+0zhh4PS0eVPhBTEud1oF6UxXa7NBSemBY6ufu/J9FXV0v/EF
         K9XxK7l2zXIwarPptt0E7dpPRTrOnaTIcBailrinocoT29ZZQvvoiMmsLXovjdwlTwOR
         JB2g==
X-Gm-Message-State: APuU4Z/iqGveF9ctR/lROlO6+1ydcMZSn68s0xq87RW91RCYuNcotoBf
	K0b4RdinqRMyKGl41sHjMC9Nqhy8RdkpMShI0Mz+cuuOq2a/b8cYpFoZkru+CI/cf2Qb4fthhDx
	oGPMfgZeuYu6Zb47KJ2oSmfGoe877n5QT7sREG958
X-Gm-Gg: AYBFou22LR5fWljD0uz8xg8DvNc4SVurYN0r3BoiwzCudlrB13ryUWnZFHbITSNqAkC
	TRlSKJbErtquQsV1O6p9/RadsVPlVuZWFNQMysNa17E3DSv13X51zqWMcI8aGW4bO4nllr/qYtz
	RwDQwD3M+MTsZ70cv/XEUVzhFithqyWsLE20XotXlq13ZKUlUfPPNvl3l2P8GlDUZ4PBn8Cnk3f
	OkgGp3lsIInb7DrgUyqC7MCuqvJbgqLM0SHtHOsD8t3pmB9L5nmmOHCUKQ0JbMig99HmyIM25T1
	cutqbnIMBKZ+oP/cIUzJ60hacmXkiKC02pDurHyPM+e0owlI+xk6OSCTkOa6FaPiSJYLr0f2h8R
	GfG2ecU60yLcPzD4kuWufWcS35zcTpeH+GwLSPdxahrJq8gaa4/8qg0oQNERp6m0ATkXqevfyAY
	GVblGtbhxwtURhn1HCRd9LVG5z
X-Received: by 2002:a05:622a:54a:b0:533:9381:760d with SMTP id
 d75a77b69052e-555171314d3mr10861961cf.2.1794255374567; Mon, 09 Nov 2026
 12:16:14 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 12:16:13 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261106164732.3939387-1-seanjc@google.com>
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com> <20261106164732.3939387-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 12:16:13 -0800
X-Gm-Features: AclHuK-l_4iDwO9BiIG7gu2Le8y5Qhu8OB2s6COZZNFQz6VTbcgN6FM9G3ViSYk
Message-ID: <CAEvNRgGHUL4-KSMCsOHznKK3fpvwh=D-H7OwSaqk2A2T0nL6ww@mail.gmail.com>
Subject: Re: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sagi Shahar <sagis@google.com>, Lisa Wang <wyihan@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index d41a1efc8a63..9982aaaba885 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -4,6 +4,13 @@
>
>  #include <linux/types.h>
>
> +/* TDX hypercall Leaf IDs */
> +#define TDVMCALL_GET_TD_VM_CALL_INFO		0x10000
> +#define TDVMCALL_MAP_GPA			0x10001
> +#define TDVMCALL_GET_QUOTE			0x10002
> +#define TDVMCALL_REPORT_FATAL_ERROR		0x10003
> +#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT	0x10004
> +

No objection, just surprised you'd add all the others that aren't used
in this patch.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
>
>  #endif /* SELFTEST_KVM_TDX_TDX_H */
>
> [...snip...]
>
