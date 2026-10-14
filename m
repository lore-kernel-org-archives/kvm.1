Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D03630BF
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997018; cv=pass; b=Fj2QDFAuFGj1mKvs8c5Q6uPtPMV3X/2yNZKC7rgFxs1oUku1UwJJd3eVKjM8GemPfO/kKRat4N+Kph7rekp61SAvLM19pshf0s2Ms+80efgkiimzkTriLTp3QLW6xyLDMt9Q/I0gCr+Y3cu3j6pivsIPT1DhoBsqroBQ9Zs72YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997018; c=relaxed/simple;
	bh=lBbwIvFL38lVOZots084p2b19l+FJ0sPwwv5pZU2vv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olnFCzjE/2mazSmFraNIcaKCBYl0aYcxZ3wXJ+WRCF5uZn3YC0Iq+IvqBMOlKa9JrryaczjGAp7vftcesuW8J/kXam09gvEQT4rl5+5mB9OX69HN9l3IndKSLmT7bzRyhUBL7OwNU1LWkp/CHZkPdM8EsDco7Al/TbjvbvGfXbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMsih2rl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJ82wy84; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMsih2rl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ82wy84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791997015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBbwIvFL38lVOZots084p2b19l+FJ0sPwwv5pZU2vv0=;
	b=UMsih2rl4o9TGA6dDeXu+seD6kcwyUGevgQiMOJn9lAokkyGWEyjuOKKsT0HnjxBm6AO8w
	EJp1+GNDt3hNIa6x0Q54MvMaaIXYkEOqSeu4gbohra3IQnZo+WTSEZkmwWQde1KPjFZx+8
	2yeSbW3iUG7omeW2ol0jks+p7yzZ7tA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-eYBeOkGpNz6IPCzvMFs0hw-1; Wed, 14 Oct 2026 16:56:54 +0000
X-MC-Unique: eYBeOkGpNz6IPCzvMFs0hw-1
X-Mimecast-MFC-AGG-ID: eYBeOkGpNz6IPCzvMFs0hw_1791997013
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dee35b50aso669462f8f.2
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 09:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791997013; cv=none;
        d=google.com; s=arc-20260327;
        b=kl2rLpUJVDOj6QCoBg7U59I/RUIl7i/Z+tds4uIdcm5xK07oavwsIytRmPL5Lo5GsM
         MwjADQuX1/y3LWH2TKp7JTOvxyBM98mcIJcwvGJFuf5P38kQ+Xr/VoBaJ4F9cxLTp/ig
         Y/nrdYJWInj25/wpFllOrTf3MtQzEo79BnJOgj7q9fJ4Pk/ntkmZuJgGXZPs+Skf0UNG
         WKGf7V5DgYjvo0zlEJW2Zygwe3VAcxrH9iTLNBH0N5YvgIi1esL+DeDyR/mCaDfY+V2G
         CCZtwxJIk7jIz8rSnjiV+TqZPvJ0k9LP+ytzIBiLxpi3WXR6mM9fhwcOIXKxN+Kw5OeS
         TOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBbwIvFL38lVOZots084p2b19l+FJ0sPwwv5pZU2vv0=;
        fh=hb/N4lcfpBYhRW5IKk/FgFCEoe7Q9L9U2LP4LeymmLc=;
        b=EkrY7033N5hiBM5oatOW6AR6mzDa91wNNvReoyT+KutS8Xg2bh+XOU9cYDFENvYEYg
         UkAA0radtvYoYewOW4BYnvBVrS5zbe8sVpytFjz1x0dmUoQrEw9MxPrkfsw6qKUTUp/x
         h9YGJWaiuGDI+y8vlF5ONdZchvtWiqS9nLztrX11T6raeN7rldfNCfhKuNJJ9S3+U98L
         HSM+tEXKELZ6CSBGrZWlur+Z4eUlsTaiVBTHXifeQZC+LVz/g6eSwDXXPmnFnKyPMr2Y
         W4sCXl/WAX8lT1VBovnOd7l9oKV+BMgHllDveJNfEQ5HB9sb8EjzQXnW1C1DkEFz7ovx
         PDLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791997013; x=1792601813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBbwIvFL38lVOZots084p2b19l+FJ0sPwwv5pZU2vv0=;
        b=JJ82wy84ILqFNMyVzLkKIUPhIEVaSckw1ACzJlORzcVZzW3ei9fZSIk5DpWGFBr7hG
         ag8HRExwPmCa0wzfrEFX8s+Bp0qJAlVb0vnzn8YbNB1iVEB0cSrz8kd664gdFJy+2n26
         q3RCNjywD2GFCtusOfCNiR9abky+dvAAsNgpnxa53M6kpr64mGzq+DZdBPVDzgXVVyQL
         XzkgCU/FPekt3bsvr9QBzWVnnIoxHroFb8wO/Gt3FbxCl/doNoPhM25T8eldIUQk0JUr
         vqE6DgwoHcB4eA6GNXeSuBX1S5EMDYQ1VfznuuuHmZi2QyaHyT7z4GMFsi8LB0kLgrMR
         WsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997013; x=1792601813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBbwIvFL38lVOZots084p2b19l+FJ0sPwwv5pZU2vv0=;
        b=dOW4x86y7/O9RbLsz7BkERA6FP8tEeq7ASQ/SlqV8iJz7vnxJ0UgbV0phD1BvwIN/0
         KZvXaEwRK5SgAYUfFQGeyqsLohXPkzjvRaMJMip8TBY5nvi7vlr2ogfmTvtDyJaNbAvM
         LPBIoJj7UhHL4D03FAPd7kTFzYwRKnhUoLztmj2/yYv1BYEdNJeLoVdiN/NESClW5vZB
         L54cH1UMIn0risiJm8hSuQTuWNzbGRN4LS/DWvpba/VZvt+aokejKDy3g7D7fRLi+cBX
         W1VZWsCkFQX37kXREpDL7z3iiceDsRYHLg7lpPYfhzUHvJJjEV5hYd2V2AiH5Cd6cyXq
         5L4w==
X-Forwarded-Encrypted: i=1; AKwUvBzE+jiBKlcwCJfTVPPBX+ayOtI2dBpZIVgtHEKF2TTu9BdT6T7FX5DrsEmjk7jGISBCy+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTZDnZQiqkoLYjxFRHvWlHhQvl9RmW9nj3WKaZ/R3aTHKKKfqO
	CNO8y1ZynDhKIeNsCycuMgJHAgIrr4GIqvrOKk57Mxqwx0HI0Bnb/TApMOZIMj7caLW84RH3hSC
	NO184na6tj2KxDbcF04/217yAqv8gbfoYOkCd0OtAog2GtuUWnFK+D6vGNN0LTN5CswWK+l/fhA
	LDWG2GW5TpceOBH+VIXaCEzC4WHQDM
X-Gm-Gg: AYBFou2d4BAXyCpszzaIB2hSLyp6BbiS/FVXKT7icYGNMTH6zimtQIYXmmR+0sLOZam
	3BdR7KxpHAj1fk0Gjhoa8m2bzswBqqlY0axKDRRpxbO15Cc7jReD/8mMxx3y7sF4atlpvZIn2IQ
	eim3LweTdexAOUoyaDJlqEwEQ6D19d3xTlnIdCieU2DPf3g/VRxDpOT8B+ga31Peykl2j8JXKas
	xs2TPSQys8NycJbZP7up2aILf2q6NpKTD8stZ7uMr7tN/HSLEFWDFbHA9cfSg==
X-Received: by 2002:a05:6000:98d:b0:48c:4a62:9af7 with SMTP id ffacd0b85a97d-48dbaae9e03mr28722518f8f.28.1791997013275;
        Wed, 14 Oct 2026 09:56:53 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:48c:4a62:9af7 with SMTP id
 ffacd0b85a97d-48dbaae9e03mr28722461f8f.28.1791997012865; Wed, 14 Oct 2026
 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014162126.964330-1-maz@kernel.org> <CABgObfYVHtFGopM=vCY2vt2N-CON=_5BN4YFiZknwvyrgP5mfw@mail.gmail.com>
 <86qzhs1ay2.wl-maz@kernel.org>
In-Reply-To: <86qzhs1ay2.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Oct 2026 18:56:40 +0200
X-Gm-Features: AclHuK9xgAQ0ZLzEzprl5qRpMX_n6sDrLGVAFdnCLrhAZow3Alf-LuTpAdZdNuU
Message-ID: <CABgObfbkbEY_MuD7Y=Y1GYSrHjp=nKfE8-Vy+QHqKMyCVurJ9Q@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 6:52=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 14 Oct 2026 17:30:50 +0100,
> Looks pretty good to me:

Good, applied (I idly wonder what the x86 maintainers would think of
KVM growing a memory allocator...).

Paolo

