Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A72D3A69
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083641; cv=pass; b=Hft8sFzVei1FVWjzw6gDYjit88Ji0Pkv6P91EFd7gnWl/9VdYFl4iR3jn8kWKjNVI/jiDDIwQl9tTQlEPDLLUrc4a7g+z14hLoXlckK5xsZHbJZsLIuKis6nRaOTRyCFKUnW98dRmdbn+sODni6RQRGVtk3+0rK4R1dE3wUF2So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083641; c=relaxed/simple;
	bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZO2dgzal6JXlCmHU85NrNgLdBqqecLQBW9x6jI2vHKbC758zmQY6aPXAghxxfOXSS5NNpRqbeQLiJ8w08d4a8iSJWbaAmKihdSGp23IGSPK2mW0894bjvvOrTrmpy40SmGDl+jW5jfjj9MriVYmvzF+QzeStNGUkfRiaSU3+LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIm941C4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBg9rccZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIm941C4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBg9rccZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776083639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
	b=DIm941C4b1DLQt0sFp82ldgF9SRX9YpLkhyUu+TGfCZOeNU/0yvWoy/dWruT2kNzCLAtBw
	d7mrJDLXfdwOzaiFU5wStqMu0GbLAqRgXpfyoerqouC0WDIZwaneOMuadfljhnI0sRtFXZ
	k4NTvOozq7nkapl9rpWkyWvkxNzkLEc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-DvNwlxtTOmqlQDHb96rF9w-1; Mon, 13 Apr 2026 08:33:58 -0400
X-MC-Unique: DvNwlxtTOmqlQDHb96rF9w-1
X-Mimecast-MFC-AGG-ID: DvNwlxtTOmqlQDHb96rF9w_1776083637
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d780757eeso674847f8f.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776083637; cv=none;
        d=google.com; s=arc-20240605;
        b=bwel3vtAfpC3+YmJs11nnocattTerEqMHuhBXKhuYfYmZq49vIf3RmXhOV1ENmlmwD
         hmaZILIpTIFEB6E4IHvTxvDNhGLoFQZmZGyRvuPjsePobggoEYw8+SkZWqvMhJ0zvX6b
         IFzs/Li+VCDMjyJL50lb/rFqmxg9dKLOM5Vtw6w91R13ePsGySi/+veV63oSXvCIPZqJ
         q7/mOmzQDH5ZcoIuelTBqe25cd8tT3pKsABRAnsC8wVVS0fSfTERZlEgpug7XGtd5ySl
         mhfEymuAXH7rWZR/BEF/zlfNZt82You2HZxZD4NrQ/dQFWxPPoc2EYor+7MKqPlPsAUl
         l77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        fh=fRw7oUKEQy4WM+iRMiqX+ccJt74bEgfwwPn2TF7CuBU=;
        b=MKEFnfRiBmMN4nIYV4q+bEoyZvx4f9yK1Eiw2Rc/pSUKFG04IZQ+/fjkN5DyI5fKT7
         RiriWF+KHof5trDRw91pqnX/Ft3yqIGLL9L+E6thpVlVahrjsew7CsvZ/9Fdg26B4nQ3
         BN6me1EvuspfdZTtnIiS7VVt82HWv4mCIPZq5f+OtMeMGvlLXUfBs5AiTnx4a8R0vDfI
         hEoYgUhdSoi+athbd/pd54GWJmTBQmQ0MNQxzDbrHRJDO+/lgEmz8SlM53NvUeP+246o
         WO8Tf5tovxAmOxNaM2Nl0LBhU5omzBk4zRDiayYkA3b2o6vOdghS+wOTZy8qfBBZzJQu
         Wq7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776083637; x=1776688437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        b=MBg9rccZJzbbCcjzSIs9HbvPP+175dqkKVy+FBrzfS5xbxZBdx8CSebL/f22Bjw4k4
         Hvb18qo3Mi9jgd4TR1rA2p9x3NogNMEvwWfU+v3iD5r56bEyaS40/RhWvPDZL/xkwSkR
         VqUV2btUuN4MrG4ONmOCcuUaEWENFDMEWnDgYsWjRCliwpEY+rjxiH3jIch6rDJ1hv+A
         mrnKQ573wt7hmrEzsr48W6bHsshxTPZTFk9zAkm+V5ma++BpK15dUSlgfM6PV1utqPr6
         rx1vTdSa4XD76Q/Pst0bZnHRImr2Sjacb9icIxo37arcSuzMz+9Zw6inYtXS0g1OkvIA
         pOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083637; x=1776688437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        b=r/NQKHtgZzZbvBhOJlkVREf1eG//oLqnzkLgFmMArUK2h+TpFnrIi1y2vxmsxaSMIi
         3jPvem94Y0TCIZd4ykESR3sQSvSx1qUHlDMCZl+gvfR4miME6EiWFsXbOX7fI3V5iIHY
         sQnpvGMElmNplXEPHSVqhMIngwwJwty07GH6PpBRdRW4yVlCLCSWUP5nsE/OwPtlN55f
         7Lr61fscp/vyr4mGWMsla4ZxZWyC1Uze7FICsgmb3hAXcE7WR3PMsuQQa7/qT2015Mi1
         i3v+gTisb52EH+3UnetiJ2H0QKt+lQEq3moqZ3mQFA0+cItR/iF28WpEy8SDyw71xLKz
         VhoQ==
X-Gm-Message-State: AOJu0YwyN0CAkSnOEA5DlxGSyy+AzMvVKneogUtQmGKjiImQvDiAn37a
	Pj9qBNoL0xnLAw2akLrp5Y7ikX6V4AuqbwUmUk0wCx+yWibAT+fozyhZuG0aAtv8kK29enRbrbf
	LdLzlBbsyNE4Nh0wBBUT6a2ekaSWY/nXi6e8dCWrNK+0V2XexKDegr7JFw/TenB47ZftzIXFp6i
	itOkbK73XZrklj/ZnY2uOEQYxENS77
X-Gm-Gg: AeBDievfVySneEkAWkel/7vChbu4wK2VKDRzNpj2Dh1ZEeR/t/Jqs6CGIa/ha7ioj7c
	0qYo0A2jCAcQED7+8UU2hhm6gLtE6S++uh/hQTMarQ7zQhvktwUw1JBFSdkUbdP8XvQyPcNWhFQ
	FvI3rq4NIU9pXZA6ZP6HylVtTYXp87mMG0PwT5tUHhp+J58clAXQPRFFV15sCR5EnN4mFmM5Ctd
	D7EOEd0VwC3voDSPKoC2kVFUAv3UJXnYfRpvy3ZEexV2vA6oYMoFP3xwqAg78RLjVP4OPd4+H9U
	L2GN
X-Received: by 2002:a05:6000:4411:b0:43d:2c9:ae90 with SMTP id ffacd0b85a97d-43d595cbfe1mr16794944f8f.19.1776083637240;
        Mon, 13 Apr 2026 05:33:57 -0700 (PDT)
X-Received: by 2002:a05:6000:4411:b0:43d:2c9:ae90 with SMTP id
 ffacd0b85a97d-43d595cbfe1mr16794918f8f.19.1776083636780; Mon, 13 Apr 2026
 05:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413104721.203024-1-frankja@linux.ibm.com>
 <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com> <3eec3725-91ae-48e4-a370-9c1bdd7693a2@linux.ibm.com>
In-Reply-To: <3eec3725-91ae-48e4-a370-9c1bdd7693a2@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 14:33:27 +0200
X-Gm-Features: AQROBzAeg5NBVyPVul8NIinRWv5vXIgL3EPHr6W2fGcFkruGU1BWpDoztdoThs4
Message-ID: <CABgObfYL-bKk7Q+cAvbigVHc8ivpdhAxSUeUSsdc5pHyoKi4FQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/12] KVM: s390: Changes for 7.1
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@kernel.org, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:28=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
> On 4/13/26 13:23, Paolo Bonzini wrote:
> > On Mon, Apr 13, 2026 at 12:47=E2=80=AFPM Janosch Frank <frankja@linux.i=
bm.com> wrote:
> >> There's been two conflicts because 7.0 received a number of gmap fixes=
.
> >
> > This is just nearby lines being touched, I think? No real conflict.
> It's code that's missing in next since we had a lot of changes in
> master. One is a conflict where the next list of selftests does not
> include the irq routing test that I added in kvm-s390-master-7.0-1. I.e.
> trivial.
>
> The other is _gmap_link() that's introduced in a fix but is not around
> yet for 4204067f99820 in next.

Yes, exactly - those are master and next touching nearby lines, but
there's no modify/modify conflict within a function or anything like
that.

Paolo

