Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFF2D9EFF
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051467; cv=pass; b=OSjw+es2+XaltivtK3Z7wiL5fDmXlwGTHcHidpNUUw3Gr7T16S3FpSqbMKdYlMwgr4r+CLP3uqpN3VnsOk8aRi6nsHHUvRlcQcxyUfFywtYeBbn8XDl6imt5llijn/PiMLuaA4URfd0QRy9GZRShBKwkVndhMgUnKlDgIND2Ma8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051467; c=relaxed/simple;
	bh=uKWCNGNkXy9iq5Loo1cQcNq3utFKwKvnN44J+WMo2ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hgx7JmPMBhxLqERomMDFTBoLhqX6CLyRb/kFeqaqD15e9dLhBIhvERu7+fnbkr4hzs9aw+7HkFt8ZftgbreQ82YlGRDE3lGxrQ/DMrZA2BZRQv4agrYoStQl62cXBvPjjGmFOFndmLmdfIT5335yIC2nAYm9+vsqBMCcTFEWLqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF43pzLt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ne78hPI/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF43pzLt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ne78hPI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8qXuGfmFvcna38soKQ4lV3fhr1max0+l13+8XTXHFY=;
	b=LF43pzLtNjSt0IRWJWKGOQoDiYff8e1hPMqiJqdNqdpCrodT0TECo6AnoF45w/1BbCABWb
	aswZDUTCn+JLY4QsQZ+iRAKMPpGUDV6W+UhQIF2gDUuJbsQqpWAPpxQrILhEZw4zmGVe10
	j7Xp1f3mWfLf4Yt+HT8XNTTHrgixw7o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-3lchEvduNoK2LXqy03we3Q-1; Tue, 18 Aug 2026 07:11:03 -0400
X-MC-Unique: 3lchEvduNoK2LXqy03we3Q-1
X-Mimecast-MFC-AGG-ID: 3lchEvduNoK2LXqy03we3Q_1787051463
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so3617561f8f.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051462; cv=none;
        d=google.com; s=arc-20260327;
        b=ddJWhpKvXg6bt+P7GqmSRWx549g1fpAS1rSPAyZkrdBzRNJ33bRTtcWlEpgonBumdm
         jz0CmcPMs4AYwMY56TlKYfbaGR8S3oTWEN13Fv513jCzpX/YCsS3wNu+5UTN2qxK+cTZ
         x1wvow54HZyUgWWkGSCXYzuk0uB7/EkXG7flKjLp59KS8Y+h5xJr7a1boK5nUYo7k/lz
         jWqdBnxv79PjBrRxURSaslRlK25n7MURN9rodf072xyIa5icMG4TOqz0Yg2t0zpa81Z4
         tuAYp6U92ImjdKa3Rki9X4rxhZkm5yUep0wHx5dOpNDBHvIQsGTN9KNgznQRSFMR4man
         vHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8qXuGfmFvcna38soKQ4lV3fhr1max0+l13+8XTXHFY=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=sKQaDZFjHKjqobXUrzXl3jEyeoNXqp0XrpjOgDxXXXUxBHUkUfDW+T88xVMX6yfzyG
         XmrivBAHvbbHy3XFo4wTiNga6XY5IQskN2pnKiZ8M2n/X+J95k/x9jjuD0w7xIBnyJnO
         /6wxFVMwMkILnhn1jiKREgZAeNUT9b2b4/X+sx6VZfZkAR7pkHOvWqXg0rafP8n8HyWH
         vKuUpGkqMKvKiz5rhik7NGDmC+1CHi2hqvugrON4zGRQRGpPD1p/IyDJJndAitA3ArHB
         zoSM8j9VGvpo7xnrW9O0G0aqpvsCu5Lzz6Cigccnrk63Veke6dlNUmiXzAdsbyJ3GfEC
         jdVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051462; x=1787656262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8qXuGfmFvcna38soKQ4lV3fhr1max0+l13+8XTXHFY=;
        b=ne78hPI/QSbKagL6wf4vNy+N+iq7edW7Z0ddPKtHAqrrfaFeHxk9CceSfEKFR3QWTP
         awyxkNjwIJAZaECTxLKInGfdSlOOpy/1umfWeS4o5z3WJkEofMga13YtZqUG8lGl3wrM
         rwdwxUGRs71Vu5Z41nCua/PzM8qii5R96iJ8n6Bgb2dZHc8UrEqWBX7tqUqqvrhcbyw2
         ptUpyP1CH1BZh1uBpIORv9FRyZqeJGjtjO04QtmKEh4jpU0bJiZhJyBJFSFYAWL2SCnJ
         rYgP30wAN94nmuQ+04Fi5dL5smuzNkayUfIfcWPevh5hbAV9lO70MDbMGxkG6bzXuqX0
         35yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051462; x=1787656262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8qXuGfmFvcna38soKQ4lV3fhr1max0+l13+8XTXHFY=;
        b=QRrjWGvZOeaU3QmuHktLahnZyo/yoWKV60O+QPaMjG8KmsgtZM1VWchFTxQKJzKUHH
         xpUzvNdZfFSsXv7Bjk+qmhaACsyYEASMLu97iVHvvtzwiDW/cSr1s0eRTGIo63l/RzXK
         EUKCjRWPJJvUrddPNrEz7oQpldf5bZTwfAwcp+kTrI73AJu7vYMvx0L5XMBqhCYUIaJR
         l2Clp3sbkv4pOd/T7NVrI0a5WWZVPs9Jh/HLKQaVZjREHvy/LXNm2UiH28lTLv7RfbTT
         hyBw2AI6DXDkKtk1h6UkBpnv0SLy51b9ZN4HPN2qmwn8KPSoCZtJhbCfg38mIJxYzSva
         Y15A==
X-Gm-Message-State: AOJu0Yx9dRbYq9LZCFw3qCzs98QDRig4fv/dImlPhfPjzyRttLO2ctco
	VE+yV9Fxfe+Z+SE5FCrPAlVW6bnKMyNDrUvXEkT5XcujHa5vPGHvNiDP7u+Eb+moEQOP7Q/7BnD
	l9IMhCqF4B7Xksv91imNJ2OHxdC9mYfJGrSvaHMV2MpZTiadaUrMAFpf5HgnxgMkSz3rp+DPAqA
	g1mjSc52/ybQPcmtKsS7X95ZZlwWqOvib6TqqX
X-Gm-Gg: AR+sD11lRqS6pxfort8ZFILX5RIz9gwD4sAl1DGUg57D8U01opqiLejZ4hcSSwxlvIf
	+KRUushK6nOAcxsHAk/hhsOKLdZT9B7XhxzfPRXdXL15+fDt66pl66zJWh8fAU9FF6Wu3FiAEu/
	2Zx0Nf6PHLl5sjWaVUymP/eXnHCEeP6MSWPYXMffo5zyrSjq7lhIf8Ziv6ClW0kEaMVsEtOGpbk
	313EHlTCLbnuHbKaBimmXhiIDcxoYgTHXPG2oNHfSgF8oMRaPDFNjgp7RM=
X-Received: by 2002:a05:6000:4206:b0:47f:8487:a686 with SMTP id ffacd0b85a97d-4816079e7e8mr55186526f8f.23.1787051462479;
        Tue, 18 Aug 2026 04:11:02 -0700 (PDT)
X-Received: by 2002:a05:6000:4206:b0:47f:8487:a686 with SMTP id
 ffacd0b85a97d-4816079e7e8mr55186404f8f.23.1787051462095; Tue, 18 Aug 2026
 04:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-5-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:10:50 +0200
X-Gm-Features: AcwNN1WhBj5Qqq8QwopvkeS9N_5KZxox0tlEN1KMqtS7CPG42ou5Nq6xBBt8J-8
Message-ID: <CABgObfaD1cikp_giXReegj9xD1-dKCEOmQ=NfDxQMF=-DROYYg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: MAINTAINERS updates for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> The MAINTAINERS updates that I assume you've already seen, given that you=
 Acked
> the last patch in the series.  I went with an "ask for forgiveness, not f=
or
> permission" approach, and no one yelled at me when I send b4 thanks, so h=
ere we
> are. :-)
>
> The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f3=
70:
>
>   Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-maintainers-7.3
>
> for you to fetch changes up to 82bd660be36f345415e0744911df141b9c31a33d:
>
>   MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry (202=
6-08-05 10:00:53 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM MAINTAINERS changes for 7.3
>
>  - Add the kvm-x86 tree to KVM x86 entries so that humans and robots alik=
e can
>    more easily find in-flight x86 changes.
>
>  - Add a dedicated entry for guest_memfd, with the usual suspects as
>    Maintainers, and David Hildenbrand as a Reviewer.
>
>  - Add Sean as a Reviewer for overall KVM.
>
> ----------------------------------------------------------------
> Sean Christopherson (5):
>       MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
>       KVM: guest_memfd: Move gmem function declarations to dedicated gues=
t_memfd.h
>       MAINTAINERS: Add an entry for KVM's guest_memfd
>       MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
>       MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry
>
>  MAINTAINERS            | 14 ++++++++++++++
>  virt/kvm/guest_memfd.c |  1 +
>  virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c    |  1 +
>  virt/kvm/kvm_mm.h      | 27 ---------------------------
>  5 files changed, 50 insertions(+), 27 deletions(-)
>  create mode 100644 virt/kvm/guest_memfd.h
>

