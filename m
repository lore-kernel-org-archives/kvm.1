Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9C3BE621
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872202; cv=pass; b=W9Wbsd0J4KqPvaguk9NAwerEEmdYKY4TLf5L8w7PXZtY7qdni10uEjkRn3BURUuNygPJiZT2yjdbhZEXQEEbbzq6q/lKynjWskwmwxcRi6ekdNOTSEdLj9PHc4ReC4Vuc1crMHe9jYEZ4rv3WH7/LFoXuLxerZ68xbpXurxzPMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872202; c=relaxed/simple;
	bh=dlojckMTP0EqbPzAwVconofdQz/0gm7fgmh/1rE97gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oub/m62N/m6XTeF3TF9p8i8nYAsIQcWO/k/Crm+8iaifZxX//hzj96guBsxLFtK9Gzg6qZg9FnFZ2Y+412IfxBqra+vVxkWA51TDQus1ePOjOiOUBJAMtZFjmsK1tsO0IZyTeAdpTqbS5BWKWHT1X7P0/TIsnyLcrdyVu94P/1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9lQ9wH/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qYCW2dCe; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9lQ9wH/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qYCW2dCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774872200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
	b=L9lQ9wH/K/fqHml9GabCo2t7U5qyzFetTXCKSRhPzTpOTUrPjYPku+5mNaU0Ydat5b2laT
	3g5RJbjTd9PO1vlYC1z6FeM4GoRxkLjkewrsBka62X/FKQP/OofOwL08Om2+FSY3VMeWe1
	EHW7DoVEmYLR8ttjs9TTXmHvG3nWyq0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-06WU38Z8MWmhMJsQxNUQzg-1; Mon, 30 Mar 2026 08:03:18 -0400
X-MC-Unique: 06WU38Z8MWmhMJsQxNUQzg-1
X-Mimecast-MFC-AGG-ID: 06WU38Z8MWmhMJsQxNUQzg_1774872198
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cff5ef652so593480f8f.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 05:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774872198; cv=none;
        d=google.com; s=arc-20240605;
        b=I/xEcsL1kzUwXv/LbXJxvU/Ou5GA1fXZfCoxKL1/4KSHIBVBUF5oqC0To3PPOjgO2s
         r+L+DO3WQErPJ7yCcFkc4/7yJVUoQVnFeJZLjpGK37cb6eFdlmy+YWxHTlCPKS31dGhr
         42Pt+kUAbBWJKXeNhniy9uHXiOk9kgJX7NQFtTvIQeSwlhKnUtTYgr/LaXCJoI5+hMVV
         19TRAqGHUx/WbIGe6dYtfGk4alJokQiQDolsOx+WhQSczjEcZG28B5UwKIzCFC/kDn+L
         WER5w6U9P1BlgnvDF1jWaB3YVEd1kYMmlV3QfUqOULSOarJ1h3/6dngI28iIN0+0IOfZ
         9IEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        fh=5Lw/HGKJ+8zJXISiApHzH9cgJ56F3WHZbEDIJ+izNqs=;
        b=VFaE97d3whiTBPkewG9bfftZOE7LhrQ16LMLIFPKBCk8cqfcwcgIFxtHW3Y5bOjyNE
         Da80mJ5wZZyjqn9WrmcshtJVmmLQZppw76pBrM4JPlTQqo4dc6NM1WjitYa2Cc2ZV4Le
         av5eJ00mxJvoxF2WNXbISZljn+puRWK3fBZ8aSR7P4i9tjj4/UBy/zdEKuizTfBb0UkY
         gbFa2jLFp+9uyLUByIPPmaZ4tmcWCXwYg6B/Bo3lLbuyS9grUxC0vl7I+8pnqFwma+lq
         uTknP7eVbozml79h5o8FbBnReE95FHjj6cTQcV9yOKkU+QZd/a2sy9PWxmnwFUiUrwfV
         7/yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774872198; x=1775476998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        b=qYCW2dCetNtc8bgmUg+o28DUf2af/r+qAvux6RVFNdBqRSZ3WN0rUtWWQcOA5OjKkL
         7GnhhZ+qC0qlonF8nr1eoWUGA1hGrezIVOGyR7NXOrKCJ/hoPNAFYHkXxJ3sI3+mCF+W
         t7OV9r8EvO7ObpLBRNKpJzoFgeCNzJuxEndFEYMFzBTGzlU3AFkkHVeLdCXR9FS/Fl68
         KV28+g/WUBEP/oORmvF9c9vOVqJ6L632rKHmbmCPfLLngfHUYsJd/uKITBbkZEHQn9h0
         tipDPvm/snaodD9NHEDLcbB2DyW2XTyjy81JQzNnEfju1D3vmUydJ9W4jXYvQ+unl0ps
         81Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872198; x=1775476998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        b=mfOu+WrbFF4f9yI5qB2ZQZC4NDveGSqBQnPHaO597s+PwG4XjfVegCRC7C1IHc6AF3
         z5HFRR+507/i6sLW9cRFgR2JwWYKQUvYutKVc2pJ8QT4x2cU4X/3GyV3ShFSo79Qtxv4
         bbT/txaTKRpOjkTRUGKnFx1Y0C12KziDs6239omJXLg2xwX7BW7zEwShJyDu/ijNRAx7
         at+KdngwELZzLtY+zIbxrZozUUik909eSNkoFpjoaWEVnKdSNviuxDRGRjWhJZZdCZ/7
         nJnKKVMPh4fIbZ/aC4m9Py2MYIWgJ42WNUwhAFFtXYSGUEOg/YuAqvyVMFv2QVmTPhkE
         UPBA==
X-Gm-Message-State: AOJu0YyJIHPmy26sVUAhctDnWrInOcLMQVzVG8Ftaq/hpcLGWPJ9ZwIj
	XrYTVbd5vpSknum9YhUETk/zBvlyMEeahtz0YMyIsznhQ70QWmaqx6KetCmS7LqNgewkLZcnsPI
	XdON0ZC1BAb/kWfOKdeBaTTgI/oSoOpSEhRgzQZg19yc2TXIlezchAKXlMKHwb76LGKV4Or3UHW
	X2UeKW5uRf9DQ9DPpka6QwAQsUoU3V
X-Gm-Gg: ATEYQzyAu0kRBOUJ1zfTqUoC4Tu4mNzL+Ef4agE3BpWaekeaDYnGV99rdwxxvWX78gj
	yFpq3ZC7L0Q95KEETZkM4pp8hzulVjO2udQ0Jf5hoUTDdtR8allOzzcr69xlliU0BU7WxHEE0Xt
	Um2CXLlvOXBpeu0ACfBwPiejE7yvrznbRImdry2lkV6WfwdxwhJBTuX2HpW0aHBgksYX6kzJevj
	KDzrqKTwzLYwPlqXa8mHZXhr5nS0b76LXVkmGVjYPDoLO/dc61RLP5Sg2XX/YOPtyDSTIsqXsA9
	ZmUO
X-Received: by 2002:a05:600c:8485:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48727d73642mr226867785e9.8.1774872197365;
        Mon, 30 Mar 2026 05:03:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48727d73642mr226867195e9.8.1774872196886; Mon, 30 Mar 2026
 05:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 14:03:05 +0200
X-Gm-Features: AQROBzB3DWnxPR3jSWpAVvne6HolnmzmB3FcTS64hP940Rx9hlh4ePIXuVThH7M
Message-ID: <CABgObfbyp0HXTozDZs9L45xMfAHRyqTKYKX8tQ=VQyCFTpqdLA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/10] KVM: s390: More memory management fixes for 7.0
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 4:24=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> here are a few more important fixes for the new gmap code.
> These are (hopefully) the last fixes for this release cycle
>
> please pull :)

Done, in fact they're in -rc6 already.

Thanks,

Paolo

>
> The following changes since commit 0138af2472dfdef0d56fc4697416eaa0ff2589=
bd:
>
>   Merge tag 'erofs-for-7.0-rc6-fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/xiang/erofs (2026-03-25 18:41:35 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.0-2
>
> for you to fetch changes up to 0a28e06575b3f3b30c1e99fc08fa0907956f35a4:
>
>   KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl (2026-03-26 16:12:38 +0100)
>
> ----------------------------------------------------------------
> KVM: s390: More memory management fixes
>
> Lots of small and not-so-small fixes for the newly rewritten gmap,
> mostly affecting the handling of nested guests.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (10):
>       KVM: s390: vsie: Fix dat_split_ste()
>       KVM: s390: Remove non-atomic dat_crstep_xchg()
>       KVM: s390: vsie: Fix check for pre-existing shadow mapping
>       KVM: s390: Fix gmap_link()
>       KVM: s390: Correctly handle guest mappings without struct page
>       KVM: s390: vsie: Fix nested guest memory shadowing
>       KVM: s390: vsie: Fix refcount overflow for shadow gmaps
>       KVM: s390: vsie: Fix unshadowing while shadowing
>       KVM: s390: vsie: Fix guest page tables protection
>       KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
>
>  arch/s390/kvm/dat.c      | 100 +++++------------------------
>  arch/s390/kvm/dat.h      |  23 +++----
>  arch/s390/kvm/gaccess.c  |  71 +++++++++++++++------
>  arch/s390/kvm/gmap.c     | 160 +++++++++++++++++++++++++++++++++--------=
------
>  arch/s390/kvm/gmap.h     |  33 ++++++----
>  arch/s390/kvm/kvm-s390.c |  18 +++++-
>  arch/s390/kvm/vsie.c     |   4 +-
>  7 files changed, 231 insertions(+), 178 deletions(-)
>

