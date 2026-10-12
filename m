Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7332E6BC
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823579; cv=pass; b=OPc9e46K1iMpyC7SjAzZEmdx17tFu4TmTBO6ZKOowf5aD91ae9AZfZyKp7VyhwBdx0g/WcgiQHaGJrP36GvqC51ZQR1yA1RnWDEe+Vzqwjh8mUBU972XgDFZn+y4ejDSLyZuRlFK13VbpwPnxtTWw0zWdCWKsvOMfvDgjc/FPK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823579; c=relaxed/simple;
	bh=oAXS6V6MF2Ql5LJpFSKH366GGwqI3OJmzAt9fON9zVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHViVem4VTpxjaRET7xONaibAaz/ho8lrGzJlQTi7N1qckxdJnE5FcsM63EstlrliYvdPJ6kX3G7a1lNtn0KfSsws3yhLvgu1b5hOaqaVo6+t5wkVQ/szxYtywwG5Xh5Q/yYJJYGjxGNEuZJpE3rb3708FP3aTCIsx4r2kd5LjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRlACDIv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/PqYrSG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRlACDIv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/PqYrSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791823577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
	b=RRlACDIvCrHlmW3ZUs4KYBoAMC7rq3McuwjHCFILBZzmWPi5oC5mlGbKQK34rzjSg9IKn3
	MJKdpZ1fpNAVi6ULLB4fxnRIZlj581eVxqm1O1CZHohmsnxUQ8rN1Q3yHNZsYn6PHZrQ7G
	3YU3JrCkv7mAtFoVJNfSFh0WJAOxdoY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-FqKGFmvENQup4yPEtkAL4g-1; Mon, 12 Oct 2026 16:46:10 +0000
X-MC-Unique: FqKGFmvENQup4yPEtkAL4g-1
X-Mimecast-MFC-AGG-ID: FqKGFmvENQup4yPEtkAL4g_1791823569
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48afcecb035so508475f8f.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791823569; cv=none;
        d=google.com; s=arc-20260327;
        b=PB7ujsvaexD8FrV9RlT65ph3V1VUpixyNvv14mGDR00Jpb92TkyPD0v+AE1S4sBn1K
         H0+Bzd+yQ1orDfE7SlNobThtYIc1K31kGiepGgAVx1q3OvnorJ+3Tkkv/+j73KMx+U2U
         0QL6Th9vhvQBSrroL3CI1LBS7AO//f5NOo0Z8LDIst+Zi/EviskNK+9/DPfTiWd29wzN
         z2fEpg/EQMkYeybl7cldKeQfJANKVVPC7IQ0PITNjJ9o8ZRRfZw3T1Ow7OqgXszReDGt
         oFCjda1jXubZQLxNBxs/ZBb0r222iStsA+db928Dhocdu0Dk4kaA69gF4hxcrAJPuhO2
         hcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        fh=hoNsXrXUAi07uxnNitMviZA7c3mRdfVClgKFEqliivY=;
        b=rEjpSVU9qvepJYKq8ipEJjZ/Kwi9+CW20qG7jLmYOL7Uv5H2Udp7VNVLFKpNK7jwFj
         typ+xZ23HNE7OOAaUaasznJezoG3g9BHzYO0Uh6nbNTYSkuf7tr68xFeR+SDtOFWSwLv
         9PYVxxi1JQFGoITxJoOKinVzqGTojAUW+dLTaAovvx1Qz0bNSC+To+Zounctv+wwHnfW
         gHNVyBitxgZXD0aIhkU7Z3Mp9h7NyEReqo94m78PmXYDKZUvnFvdzmH7gbgol9S9Qpc6
         cTYS9EPG/2gohUP1Hhxoc9xAYsuYm+AJ+F5kewnD1MdmRnTgUum7uaq8l8DmwVo0OAhO
         /+3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791823569; x=1792428369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        b=K/PqYrSGbMLD4cr1p0bUSPaSdk7BqoFT5E3pl3Ei0hTq6/+4nfXSipnYzci6Ljf3lJ
         wux3gvg3esVbl9moYAXYFreLHE2PYZym/zbfdQw2t5YsNklXajbvaDXXvi5ZutJjl3/Z
         qH+LXmlwHzZT4rEcpAH9Vj3y5UuhbaZt2JmnqLhuZxF84mR03GLCl7DNIqhvLHBzLL7B
         ejuVVm3VU/NAQyqotGDNOHivD1eceOa9cpD6AVNJTAEGjK2e/VV5285GPNvTnf/gBbCC
         3fFoUbpHR4af6YZqC5t9NQtOvvh/aLeEgOEQ8kRm+kiSb8WbvXvakkepecMzSCgZOtHt
         vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823569; x=1792428369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Xrn0w9zhcSyTIcnhYHLvfCTc9jnY6eC1cxeeEthPCs=;
        b=W7s3NRVgugYAFwFPoWdWAsagC1CARAALJqIKc0V91HvsOZwl/NoTiFP6KKcU/lAxcZ
         hhsOJUoIOni/EJMbivomzkKV96wc95MUi4piaRTdEGFLl0Vv4uNoQ7R/bLfThsJTHiem
         5HNjHcW+JjAr1bw11nbB91jGZwalSrkMvX1SL7gU1RCUjfp2kzDPNA1xNO3l3iZcWw9u
         rEE1GysPT4fTwuuxU2EqNCBO/j4kHd+Xzx3MrPzlV6808lSvlBgkKs36uVkKPPv5gdUB
         xNkfiS6Ip5S3kKn3ShCnWVD5Y5C+Pl/Erxhrdt9rbDOZLywYsVK9kfhyAdogLL4N1fNu
         N3WA==
X-Forwarded-Encrypted: i=1; AKwUvByqxSJRBxP//ez/NJPh9pAsggRoVQXpl9XGBIjwVm6p8fr+ntWeI2t/fYJaTN8kcYJt8No=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFC/kgm7bUhl5Lgd0le9gFfCGXKw+Vpx4XwEuUUJm9csG7WTsL
	TDNsrUIVmRhDcFUBFBO9e6vmBkJl9uGbx0/tuTXQh2sasKF288CmHHYItZEiOpMd4o1SZxqQ4SR
	YuXajOFsduelPx/94/3o3Gm+yl0/e+8UmYhohxgmQ9yphnYsUx6EyDWWjWAn/32XAD9LxLlaaUS
	o5I1IHWe8zahHHt8IeGfa590f40cxlHG7tzvUwrCs=
X-Gm-Gg: AYBFou0MkE8ha1c7/BqrWtU+RXtjrpv4HQ2bAF0kPgayNWaNdOrxtVSLEfuHG4Owlq6
	E6sLrvIkoNz7FrD1nIfCD5hLkVroLJvQNRlpGoaJw4LLxMhcrFjv0dO8QRPLkaeBkprui+8Cw7z
	F/Ws8fc3t17SzYOfOyxHpKd1p8J6XWrt2kX0cijpLC9vkp0DRYHImzFkZSukBmapysh0yjOeIUi
	j6ixACbgDCcGGcAaFcXsb8aTB1N9cV1SjUTyM9AqpdAHQrNuuaUYmdcOAEMew==
X-Received: by 2002:a05:6000:61c:b0:48c:58b9:f17c with SMTP id ffacd0b85a97d-48db947461fmr19542070f8f.12.1791823569145;
        Mon, 12 Oct 2026 09:46:09 -0700 (PDT)
X-Received: by 2002:a05:6000:61c:b0:48c:58b9:f17c with SMTP id
 ffacd0b85a97d-48db947461fmr19542035f8f.12.1791823568768; Mon, 12 Oct 2026
 09:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com> <as0NBfuEY-60pgtz@google.com>
In-Reply-To: <as0NBfuEY-60pgtz@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Oct 2026 18:45:55 +0200
X-Gm-Features: AclHuK9pVodaU0y8aFoEzn0G64V6E6NcOQh1xijrAviXyHmZnBb8SlkbTzGCjn8
Message-ID: <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:38=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> > When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> > in nested page fault error codes produced for shadowed NPT.  The AMD
> > manual is unclear about when SS is set, including whether it can be set
> > when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> > of the VMCB; in fact, bisection shows that while SHSTK was available
> > to guests since Linux 6.18, this started happening with commit
> > 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrelat=
ed.
>
> It's not unrelated.  As you note below, this is purely because Hyper-V on=
ly uses
> CET when GMET is available.

Indeed, my intended meaning is that bit 1 of MISC_CTL does *not* have
the side effect of reporting SS failures...

> This is wrong, I reproduced this with the KUT CET test with gmet=3D1.

... howver, this makes me wonder if you meant gmet=3D0? Because if you
need gmet=3D1, the Fixes would be fe080f58dec24049 (i.e. when the gmet
module parameter was added).

Paolo

