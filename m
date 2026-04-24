Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0822BD01B
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015154; cv=none; b=M5H4w8I2ofCfVXhsd4KjNlkfVBa5J01fItu7qj593cqbZXGCapK0uvYQcP+MGP4S/7bbQa8JPm7cxz7GrUBXHsCplZB5fAdGFJLjsnd5b2ibmZYw3gN7YA8Ndyb8MHHaR4whgduONrfr9eNBVaLE2AukUgpGeTyBg0oVUyOBo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015154; c=relaxed/simple;
	bh=sTsPpKap5OGq+wIIGcSU896NKDzn+S0ucEPsg5kQ1bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmR0iNmd49FyAlfgCibZOm3LD/cq80HSR74N3QAbyhiXUCEDi27OLSRhgJxNAElNpcZjuPJrxIZ6vikB+N51qc/koxCj90c/sc4lpkhcu6CH5F+VLwFhzOj3UtYPwCC38ZfHYkbC43s54GZaCsA90rXd1ajGLyA8lfQ2OYFM4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkWcQEOf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctbfaZIk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkWcQEOf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctbfaZIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777015151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CKSihAV1WnGoX3aQAc4A0PVHPxeBUauOit3AYVj0CqU=;
	b=PkWcQEOfom1lx05VRl/PABOMhltbBIfJZYM7dajK9jRJRc5elRZMzxfMjfvDS8MmU8kz6l
	ujGRqj1mjsadzjE9k2P0wvIsM1Qafs+36c+xHPoypj4WxKkTplgkZ3LitXdBmCM8wiYY0j
	BdJjAepAqy9Du611CqN2Ht1pmPFJ+xs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XkX3mRLGNmiJyJga-czrMg-1; Fri, 24 Apr 2026 03:19:10 -0400
X-MC-Unique: XkX3mRLGNmiJyJga-czrMg-1
X-Mimecast-MFC-AGG-ID: XkX3mRLGNmiJyJga-czrMg_1777015149
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso7375308a91.0
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777015149; x=1777619949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CKSihAV1WnGoX3aQAc4A0PVHPxeBUauOit3AYVj0CqU=;
        b=ctbfaZIk688JRQgx+Gz9gz+iHZ5iWFVvZnvaKCPbDKlvuXf+kIc7uSAkc+WcaIp6QB
         OSVrUGJrsTdWQOHhfTQ5tTZS1v2Exh0JpGYBRNMgwgu6XDT3gy2QOu0+wVefPY0wHDhB
         8pDRA+ah1Lgp6pcnllOvnsTAqQETpHNcgYT4N9Sq7mdugUg+Z0V+RsbAtQU8VFY9xJEc
         WdUGLighh4X7yaEPhPy6bfczpZA8Lxl8+kDYQCrvpvU3eFa+ouP/Wzsn1u+/1wU0sVJZ
         CRXfVmYfV1JKJ67z42vflzMKn0rNfj9A6ejIzq+NEKi2Ox5qaYIX7LcpZLdOxMP25ffh
         8+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015149; x=1777619949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKSihAV1WnGoX3aQAc4A0PVHPxeBUauOit3AYVj0CqU=;
        b=KCxvM6J5bQdu19cOx2l06JRuHcJJ+QuQpBie1OaZxhmhIxiNMFDyEphq4HayULaA7D
         duf8YTaYven8qoPNuEW+5XvWwaC+FqOApjZ+8lOg410Ll3fQNDHFeeymLYSg+3OCgGcg
         UlxZP+5XP2c+30KO8Gdl4L8g+RHVCpMMDi6L1WxU/eiIY4ArLbdu91J8UdGKSFV34oKM
         GokjjY9fN6Dh8/h4kuDklygYyOmh7WEY+1cWSvMuCx8vAVvHkbBE6mFHhPl7fSlSE0fz
         YKNv3VKJPlS3/ZRORuIVD/D2Lq8N7w5q/5YpFhs/WydOs7kRyTo2rXzUo62DJLmbjg20
         rUSw==
X-Forwarded-Encrypted: i=1; AFNElJ9fiRfRVMEMwC4/bTQfDsWaZjNMUZnDQdWMXVYn9iwy+RHa3EnXMstHY3rSfXMwGbNGR38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymca8i+SpvTRlSYXedN/nMWV47XfelQ+q+Cq9hy0hgM0yFn3pE
	YvXit6Bl6k47VxRNjhZzZUXVxmijmkQcPlXicW3iiBZ5oW9CGyK36FVHCezlI8H7tjLKJU1PdKe
	VmOW2C3A0VssrSqI3SLFdLtj26Z2Gl/qPt0JDW//U4JbTwPSjpLtA7TdXAKLCKA==
X-Gm-Gg: AeBDiesp95Jtjpa97/okRmCZWAvJ6TwmvXGwRXofVoClZv2dC+bogoF+dzClsJdToj9
	QTrw1RjVema7NoYLpFqA86dtuVWKExYbkmcIuST29SPl1OJdYwKNqP5E0WVHp5o5i56YQ2+vXZy
	sAGGYH4wLsi1l//GodJ/BATfjo25Jl+xb2T4Ir0WQIz/T449yeCv1i87FSzPhEIf8zFZRk1P8KX
	2sEwA/10TF0pGQFcXiMR7hAE2pSAjj39yL4FnVFkYHwWWRxnv+QBX5rkL5yNRf8eesKmwpUT9GF
	HLlsETrny33fu7hcn7td7WnT9/b/AGe+rc4moSmdPSs21ONrsI7AWcSBcUsaA6mNbmzyQ6giAu1
	d/fPc7TtRuAFRIlEb5mdNEctt79M7EA==
X-Received: by 2002:a17:90b:4e85:b0:35f:bf23:bd78 with SMTP id 98e67ed59e1d1-36140461d2dmr31827152a91.16.1777015149325;
        Fri, 24 Apr 2026 00:19:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4e85:b0:35f:bf23:bd78 with SMTP id 98e67ed59e1d1-36140461d2dmr31827113a91.16.1777015148848;
        Fri, 24 Apr 2026 00:19:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a9fbsm28978118a91.11.2026.04.24.00.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 00:19:08 -0700 (PDT)
Message-ID: <16bf7ab2-c4ad-4982-9170-cd06015c39f9@redhat.com>
Date: Fri, 24 Apr 2026 09:19:00 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 0/3] scripts: Configure and update tools to
 allow basic b4 usage
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2026 16.16, Christoph Schlameuss wrote:
> Provide some basic configuration for checkpatch.pl so that use on the
> command line is less confusing and actually useful.
> Checking new patches with i.e. 'b4 prep --check' will now not just give you
> dummy errors.
> 
> Modify get_maintainer.pl to work when called from 'b4 prep --auto-to-cc'.
> 
> ---
> The second patch also copies the current codespell config from the kernel.
> I think this would be nice to have but I would also understand if nobody
> wants to add that dead weight here. In that case I would also agree drop
> that second patch.

IMHO the dictionary that comes along with the codespell utility should 
already be good enough to cover most of these typos, so I'm inclined to 
rather say "no" to the second patch. Instead, maybe you could introduce a 
k-u-t specific spelling.txt to get rid of the warning message, with some few 
entries like:

kmv||kvm
RDSMR||RDMSR
WRSMR||WRMSR

?

(the latter two entries were fixed by commit 784dd85d25d484)

WDYT?

  Thomas

