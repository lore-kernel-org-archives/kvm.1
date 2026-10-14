Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF855D889
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995472; cv=pass; b=OLkExvEEKEOkTaLAJyqS4RWwh6YKMU9pH39eZW8dKTWqwmH48wZf4GadIXJv5qQdI3yOR5CekBNQ3AzQY1i+26EUnBqFxQtO/bU6yhfPlXyYGzCrBg4p7vjPgREiyNA7UkO9pTVZpAynp9R01apjsccRka0Nu3uk+WZGm21hkyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995472; c=relaxed/simple;
	bh=zy4EIi1Qm5ZXQfZQEHtR5SJYjCSsE5RsXuRQofIIUDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyxzppAAB31qqDStGS8u2Zn5xD/4yZ42II2e9s3rBjkPOADTPQsCpzGqeKv93okrvUPEZuMAjBuD/8tAG7nvecCjCXUEMyRMetLd1Ec0J7pUbv4h6muwv3ePUKZEEacD9wl8n4T5+9ZbkYtlwsBmWWrD/AJS4z8fZ2hESC18IZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtEdRiEM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcxhrX8w; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtEdRiEM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcxhrX8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791995468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+0bbYBp5vS6Wzy92SxhIlT3F+PvYBDU5sICwVgEKDw=;
	b=OtEdRiEM/q3OoCkRiLtmYcXFc/3q4v/Cv0KwuqdgpIu0gJFdOmofg41YqQYHJ56AY+vDHu
	kPbulanFmQ+4AE4/UAMi8djtmRPTG/0N2Bjy7y3mrC4vJsnGP7p02YMlIKOQtivKB6lpQ8
	tfCtyCTaaQFweVntt9bpnmXHu3WfnX0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-WebXUadwNCSB-j0j3CMpiA-1; Wed, 14 Oct 2026 16:31:07 +0000
X-MC-Unique: WebXUadwNCSB-j0j3CMpiA-1
X-Mimecast-MFC-AGG-ID: WebXUadwNCSB-j0j3CMpiA_1791995466
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b00febba3so3416930f8f.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 09:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791995466; cv=none;
        d=google.com; s=arc-20260327;
        b=Z39FzPwdQXk7BmGi7JTwVZTLUGRo1Vb3kDaFvzK2fw6JoleKNzCPjnhFaEYqsbuM6O
         sXWWyyjit0FER1fHTv8bFN5SHHBC4xk+2SypAVKlvm/cpXHY7jrUkRYJM44cTD7uOC0u
         SKDJLyeZDcPsBMCIw2llGDzyJ7OIW86c0PqShWfYRGg/IDgtNt0mSy/RL/9wfl44AgZq
         k+vY/6sp5Zr4unV6KGasF31feirkIM3GbW6RAfSyosuB1CNt1nh56DLYMcJV0HynlU0b
         g3w9funN68Oq2cdyQQ9Y67lhxgltM+xSC/VsNZf/APkcEaHENq0oeGu7OxYA468pdRb/
         hAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+0bbYBp5vS6Wzy92SxhIlT3F+PvYBDU5sICwVgEKDw=;
        fh=ZqMldv1TbIRfU5ACuuZbUQND7Pfzyo4kQrK6BOG8oPM=;
        b=Pu1g89kbymNX7IV4STLRz+SEu8hyXi1WuKKKFWAVyLaG0rQScObOKOwRRUHxVBSUeR
         wz9PrFq6DdKNNNR6R7ins+WrY7JSsJ5+X9yCWOkVEXHKP7vc5lJIioksInWEpUxYSoDy
         4ibv5twQd7CifZmcrQLg9yV1XmL3WZq5hJeUKtopnhG8p7h3b0PMcYqMgPNIBWic9R9U
         IcIIgHDv1+d0cG/Hf5AqDn/2z+qhr7lM2D9L23cHX2Bsd7sqsHT3DTfWKWx3qOLd64jt
         3yqJnyPuBnV7SoKJklRsi1/RtjiYmebLgxSICuZjiW1dql8j/OSB8c1gCdtYtJj0aGf1
         3rbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791995466; x=1792600266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k+0bbYBp5vS6Wzy92SxhIlT3F+PvYBDU5sICwVgEKDw=;
        b=NcxhrX8wMBKw/1wSsC2g2NlOPh3Uz6SgaFnrYVAF9wMJfPOR+e97tS7k2PiBL+ArH0
         5hgr181qm5Er5qVQmzWTkNqsQbFq/6koKUSbTOd1RjTmjUVHdzNIJ55HjgN7MCSjKb9R
         tcoRMGyBLiWfK1s15dm1/4Nf65nfJkSeMh48T1sm2nBYZpsN8z7m0j1+ZFFIwvW1eAvb
         LFqFYEJTQcjI8v/Cif/+UiEWyQJGP/WkTTB+3eLDzarlhp3B0SH37y32JZhxgxuVsCld
         Cxvf5TpxZ+bsQpDiMPxbO9JItAVOmT8J2VMvyb7zo8PUyGMuEVwYPxK+R5qj8QQffSNH
         XQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995466; x=1792600266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+0bbYBp5vS6Wzy92SxhIlT3F+PvYBDU5sICwVgEKDw=;
        b=cJTWdlHKuGbLRWdZAWhcxmPAWdDLLotLu5PN8b1Spcb1EGaoxVNTnLft2yGowEu2oA
         YKeJgbHOAnK2Oc6Vg5TerYuXUB8unKQQRrXt7hN15QrjCxy6jOZWFHJmVpyeI6DqjZap
         fIWYVewdXSJMPrLj1m+xj5//04N20RzE9V9DXErt+BlkfRz+qw98IyZRtEMi0hFYv02b
         4VHkCV7kpcXwyOeMuJCxYTFm54R9zKzWrHXRCgTt1dvjPOqsPdhFxHUsvB6pFXPN2NLj
         v/Q6KJz1q0FAwuCL+qR7AubC5subBkb4Qmk+Quezt2/zsGkXO4wluTCyf/GR0lVi02Gx
         MTxg==
X-Forwarded-Encrypted: i=1; AKwUvByT75taEyvuknOrULztdrq7zJMumcXUdRB35sNaavzMZUcAVAf04McOgtqMW6r2kxSa7WE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrhAhxjPmPW2iiNQxCINqCVhAWirOyeja7wXmE5GsnXy1ms3qh
	Gb8FNso0ifBeso+fhEcGL0ULQEZQKd0TNryirmnGcRuFZDNwGrLM8DJyq3axG7FpBL9wUpja3Ew
	FHUbh0mxTklz2xrtM+4CQc9cXg5STHXCDaL2otGunk1oXCviWIQYSDtAHSzq0hRfuXXhC3M/Qtz
	mXyny8+YNevoOyOa5nTkFhqN0Z4lrz
X-Gm-Gg: AYBFou0YtwzpYVo0he5YPUtg3dbSOgnw5RTNXsKiP3X0guGoomLo9zZrlVLop2cLRUc
	27vczok009JrNVLyOUt8RV9rRewyH9ypGZHehI6dQPh+utM6MCjf97ZkzJ41T8OwvDkwI/lIMZI
	xhxddjSXU3XsMM+fxuTQx7sbAuBimNOYHnTXRSX7Bb7y42aiKczYYrz/o9JeeVdAl6+DpTfcTjy
	CMwmrpnGDv92Nclh5v9mJs03t4AbGl3tJ0OApdXblfmv+u+PH5JV9IGM554vA==
X-Received: by 2002:a05:600c:34c4:b0:4a1:b027:99dc with SMTP id 5b1f17b1804b1-4a1b027a161mr98308805e9.18.1791995466240;
        Wed, 14 Oct 2026 09:31:06 -0700 (PDT)
X-Received: by 2002:a05:600c:34c4:b0:4a1:b027:99dc with SMTP id
 5b1f17b1804b1-4a1b027a161mr98308215e9.18.1791995465797; Wed, 14 Oct 2026
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014162126.964330-1-maz@kernel.org>
In-Reply-To: <20261014162126.964330-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Oct 2026 18:30:50 +0200
X-Gm-Features: AclHuK-uduyx1V7w8xPq5hTQncfjGaYTAtLpmbc_jG8-KYLjkOQH5FYBRTis6z4
Message-ID: <CABgObfYVHtFGopM=vCY2vt2N-CON=_5BN4YFiZknwvyrgP5mfw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 updates for Linux 7.4
To: Marc Zyngier <maz@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Colton Lewis <coltonlewis@google.com>, Eric Auger <eauger@redhat.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Gautam Menghani <gautam@linux.ibm.com>, 
	Gavin Shan <gshan@redhat.com>, Gokul K <gokul02k@gmail.com>, 
	Hemanth Selam <hemanth.selam@gmail.com>, Hiroyuki Katsura <hk590@cam.ac.uk>, 
	Itaru Kitayama <itaru.kitayama@fujitsu.com>, Jack Thomson <jackabt@amazon.com>, 
	Jiaqi Yan <jiaqiyan@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Jonathan Davies <jonathan.davies@nutanix.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Leonardo Bras <leo.bras@arm.com>, Like Xu <likexu@tencent.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Oliver Upton <oupton@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Sascha Bischoff <sascha.bischoff@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Sebastian Ene <sebastianene@google.com>, 
	Sebastian Ott <sebott@redhat.com>, Shen Yongchao <grayhat@foxmail.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stefan Teodorescu <fane@google.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tharit Tangkijwanichakul <tharitt97@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Wang Han <wanghan@linux.alibaba.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Will Deacon <will@kernel.org>, Yuan Yao <yaoyuan@linux.alibaba.com>, 
	Zenghui Yu <zenghui.yu@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:21=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> Here's the set of KVM/arm64 updates for 7.4. After a couple of
> releases mostly focused on mopping the AI wave, we're back to merging
> new code, and there is a lot of it. Given the size and the conflicts
> that this generates (see below), I've decided to send the pull request
> early.
>
> Details are as usual in the tag below, but there is a few things to
> call out:
>
> - a lot of pKVM updates, finally delivering on the isolation promises,
>   thanks to Fuad's work on upstreaming this stuff.
>
> - the first stab at sharing code with s390... More fun to come, but
>   that's a start
>
> - More GICv5 code. As always with the GIC, it is huge... But for once,
>   the code is much simpler than the previous iterations, and also
>   comes with a bunch of selftests from the beginning.
>
> As a consequence, the diffstat is a gold-plated pig.
>
> Things to note:
>
> - this drags the kvmarm-fixes-7.3-1 tag as a way to resolve bad
>   conflicts with some of the patches
>
> - there is some additional conflicts with 7.3-rc6, due to
>   kvmarm-fixes-7.3-2 landing a bit late. I have stashed a resolution
>   here [1], which you can either apply if you're basing the merge on
>   -rc6, or mention to Linus as you send your own PR. For everybody to
>   enjoy, I also add the resolution at the end of this email.

I've done the unspeakable and pulled kvmarm-fixes-7.3-2 into kvm/next
so that this PR will go on top; that conflict is too much to send to
Linus. Please check in kvm/queue that I copied your resolution
correctly. As soon as you confirm I'll move it to kvm/next.

Paolo

