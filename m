Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E991A683D
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697191; cv=pass; b=rYZY8df67ID7R6LS3EwbIztfwt/3NG2jzktxh08uGIu6XzZKap1euJdtE41DR1Ww0iMdZNrFN1netjTAcOUcyz7pcGIMmqCn3Q2xalLHks7eel20v69u7TGSYraHssx+KjEkW85AndwWOrtIWPpyz0w0ndmIaBV+M3YGeNttF88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697191; c=relaxed/simple;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUONkojYNDtH7Mu8CDdUUSIMBN9QNwRrGgEF/9b1Li/KjILSQa9nIBy3EuIkdSyslBQopDl4J5WtiMmnWG5dp63V/1dmiqjGN4+1HJLxLfsckEmMGvX7Wt14ctayEk+4dZiE2C0sMBeEMSIDHoHD147AMZjIFlaMHC3jjibtY3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guS9qKyK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb5HvBnX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guS9qKyK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb5HvBnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	b=guS9qKyKHCLfnROCdmiJut6dro2qAm2B3AZOul6Y4u+97/IUaNMe27THtK/ajJ+P5BPUpD
	CHpEI++2ukqhd6dxbg2NNyBXhs+rzS1bC0gzU6tQx0lyOiy+pp5r5chf71UDaJln3CKK1p
	OaN4l1AL6ziS0yI9Xh2bI2pNFs2LWg4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-U82As5yAMcmhppF-UmOGVA-1; Sun, 28 Jun 2026 21:39:48 -0400
X-MC-Unique: U82As5yAMcmhppF-UmOGVA-1
X-Mimecast-MFC-AGG-ID: U82As5yAMcmhppF-UmOGVA_1782697187
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9667280edeso532185a12.2
        for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 18:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782697187; cv=none;
        d=google.com; s=arc-20260327;
        b=KCKKDLE9NIXmy3T+GDKXHDh3RdJqrp6bj/aImzrPmWcE9hWaefs8XbQO7xkqnb/1ak
         3slIwIAzDnBTsIJKvwiDoBrupLN32QrbhbpW/MQ5571qESqn7EyFuB7Q7OwiOMhARIYl
         WOk95KlkOarj+GAT8khVqHvwKxL1iMAqHbGXVtVJJzoq13JtPk60uv23wb7yNCTquJht
         5WJ7gJG/SyZ1ZVLpfBxrkWg/Ymnldt9H8rtOMiRduEc7UAcV9ja0/+mzQc9+ZyzlukF3
         VTtJP+4OTMPjFsfl00/iGQVImLF357YB8Hy66JUgp2M3huY2RRU7LJis2iuitD4IAYlJ
         LW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        fh=GxxCPlrg6TYLhPyNCoutoymss3B8uVQaHt5SBSCsEaw=;
        b=RpnO5cVIfWWOJsvpBwQ1Xjy5TjBu+GcGDQ7up0tHmG+d88e49ecvrwziTkAUvTQsZv
         sMsi3PJ/js5X5k011LVPh4cJsX0Uu4KQoxfz3/LIsWkhGirEAH0t4sGMp8czaOXXZgfp
         RlfTjj6FWHxhRHH1tocOwrOOLe1wXkVt56aTYoFxLxQhukbuvSCQiG4i6wSjt2ywtkiv
         cx+69ftcSqANIf/2EQys+GASc6xHYxGhXW3rUREZlnZ3zYrdm7qbBCzyGDg/1W9ObszO
         HFcMWwuejVa8TLpTERbXrl+WctAmw3hdTvRvu+FiRSCWq9+HKLdglnvoxXzEeZ1iavPW
         STcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782697187; x=1783301987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        b=gb5HvBnXoNXOyTSnIAkV2b4c139EJEcEVPMaA03/8XlZMlrj7z1yvqT/zdWpHYcAbM
         uaPX/8f53LC3oeogPs457egcIioyT3AluBjNHUGSnnCMa4Ebo+7qqXYpGtXDQZLd1+B+
         ouq/40xHQlxWFfWwmFoN4FskH4mG0sUtj+B4ffl+cn1Pyu/U/3wfg4BqigNGSsCfYxlC
         gcwaZmLcPzbavNbnMEQYpjEeSlGknp+05Ejk7BwOOOFvaN6FM5ZDGH/aSKrBvQX7WKBG
         rwrOL+8e8EJReWHdvkjnd/Rby6rMtyWYkb3mIvfxBzx7PcwKno0VlaZi+zEA1+Jmvb3X
         3Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697187; x=1783301987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        b=gQOZymxkxg/0d+029Uubr0YSQbVP6eTcASfjWxKQzGNm8Kh/xLniOd6kD096biiQbr
         WIOLFvUkBiciYGsvlcHNep9Tjcv4TthSO0ArQNdD1ZG4kyuWftLooTegKu6gcB70a6gK
         znBSRokxbqMgN3EvBtNxTyXe7QIaUJhUZZmH1CXwmjJxdjFtHKSfM8GFNMabowwOMIi+
         7OQrBpGDHn/Ze//8VDcBe2NI3wu6Q1+NeVM95DAf4yHyV093LiJOjuOzI4Rj5gQLIWiN
         ZUw9Qw75aEj+5rv+6TsL7oym8gYF0Bx7RnZmktfPBv+moPa6t78PrMs9LPgABSaCOWUB
         cT2w==
X-Forwarded-Encrypted: i=1; AFNElJ8YjI234oud0wq5n1g302E924kHDc484eTcOpNr+3SCzkzq2gZRfXaFv8iIY0pwTObnw94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9S61PhGDWBVu0K/7TktAo//trnNKd0Tf8lIcipyWyhWVh4rLj
	0O5NH2oMPBr18Vt5yYBvpmAt9lQPn3vPCecmTA38lj+2BoXzC3WW5qZBmgBWXi/3DHyzncoODGo
	BbPBtY+iVNQqiBf1KHH9SzO+8Mwy8tpOfCemLQwvWX/ZvvCiq7Z99sAqwnVrHTivjSX9vo6GAWL
	upQi7p6pbSU/MyBVL2aph/3Ku98cfR
X-Gm-Gg: AfdE7ckt61DL3gPx0+ilDkc6YEH+Bg/89maDUAyGlKPRoORU0cALOqAMG0TGBavaRnY
	ULzjm9voVm4NPFi35xt2wvXCtY7hcUqAQfxw1DA37Ss/o63bjpMKSqKKwPHYYX9XZfeNHJ4VhKv
	mD2v02bXMPa6mWg7BFzE/IPiqNXPi+cfeRg8HEq3H2TDDPhLi6YQqOizp0cnWknI8Jg/DYkw==
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3bf735d848amr6431521637.27.1782697186988;
        Sun, 28 Jun 2026 18:39:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3bf735d848amr6431502637.27.1782697186452; Sun, 28 Jun 2026
 18:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626022039.96139-1-jasowang@redhat.com> <20260626180433.3e302324@kernel.org>
In-Reply-To: <20260626180433.3e302324@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jun 2026 09:39:33 +0800
X-Gm-Features: AVVi8CfiIaaNu4XD5f16KUtQbZkJ7QsuoHzBIziOF2mgWVcE5Rb-guxFM4B6N3U
Message-ID: <CACGkMEveL7Kp8PJfbOX06LhboaFZt_1tqu7z2rvCnO6yj9kSkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Jason Wang's email address
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 9:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 26 Jun 2026 10:20:38 +0800 Jason Wang wrote:
> > I will use jasowangio@gmail.com for future review and discussion
>
> Do you want to add a mailmap entry, too?

Exactly.

> Otherwise I think you'll get CCed twice (once for MAINTAINERS and once
> because you given tags to previous changes)
>

Yes, V2 will be sent soon.

Thanks

