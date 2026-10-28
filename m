Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210815;
	b=z1gd/yeyzQ11wytf9jAMQboSYXW3bUYMsiSZuHz1emvszwUqcMTqY1S8LrNyC6hnOFP4
	 TMKbE6zxi4s7Tz1F+/ODF/Lkkh68DqK/uMr64jLcOlW9lJz/GhNE87KklzGNxkDRzwPDh
	 IKKBruqafGqfGbQ6GO2ek10yTdJq4ksALGK6F88bfPL/6w1NmlsvaAwe2aoZjedlHhJVR
	 +rQRnflGvtzmLI0O+6diJfgOEsHJcraR5b9BtgXbV8Uzuek82OEfyC9n/8ugujgMOzuFi
	 +ul+5MAfy3F6t1z8yEY2aHgbU2w8abJB7zyfYospXnRhBQyYMmDW5bIK2T/b+j/9NGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210815;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=YCIM+YQFrajHkl7Ol4fId4ZkAJB6I0ksGBZA0GnY5pM=;
	b=RXV3VBnwE0naRVX6v+YRHnsuX87CvQcCaem2AZ6B/INJxfEgjHW1urJLJqmnRmL+VtJx
	 JW5s+1PbKaAjm8owQgAfuwyE8eEGdZayYT8KKyIJVVQiQ5lUyeYaO1LGg1fckMP7kWf6s
	 mH14dvTzDndnojucSliWBTL7HV87Hir/gzxsnPwefvtkO7LgQ8P26SFfYzZmVIWvcxyNc
	 4TziQGVWAladrFMDo+LVccIhSYL+6f8BgFZzT4Jz6O/LEjErtvmwUgt9o6i/gIFoxYGvC
	 QBXY/ciCFk/DSBpTUk8VgSP9OHPImVeBq56BmtI2+8qHPz6O/YQ8OJb+tUJbzifbGLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ftwbVx+X;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C6zJWfft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE3606A324
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48DE3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ftwbVx+X;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C6zJWfft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793210814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCIM+YQFrajHkl7Ol4fId4ZkAJB6I0ksGBZA0GnY5pM=;
	b=ftwbVx+X7kyaaoB+Xji1FTum2/KukPUx2YNVsyF82Co/85PHkkF+DIYtDDCRaAuyGSHkG3
	oOQ205uqIc8o3e0gU9xMZdX0vRoxC5TIDhOsP9RCHZrJnj1VsalgVpZD7QU/eDFrj+yfk7
	6YVuWWnNEWD/SK8FqlVO+9vyIWd8HEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-fJzbXf2JMAu53T_ySeNbTw-1; Wed, 28 Oct 2026 14:06:50 -0400
X-MC-Unique: fJzbXf2JMAu53T_ySeNbTw-1
X-Mimecast-MFC-AGG-ID: fJzbXf2JMAu53T_ySeNbTw_1793210810
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0c896d05so1051010f8f.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793210809; cv=none;
        d=google.com; s=arc-20260327;
        b=DUgjcdDtaxnzVydEoo78WW7J9XF+tlDPVZe2rhEQhJ0MTGr0B9yTfI2SNbM+aLXZgo
         m8aX+IJJ3qdDIx/uPLAmTVNrvC9vgHtLIZEZ+HjxtjvSC80JdROJVxkc873l31JEn9z6
         cHn4OpC+NGGj5hIm2mcb4HXP4dOoY+JpYtTkWnYeKO3FrWwBdNe2OCwYeQumuRglBgoJ
         /mm5bhmwswBbfhlC0hsOU6HDAHb+YoFj6xnxIVR3GOZnt5WVjPhnqhdFb6iOzxTFaugA
         1IIL5z6rQ77yFQsrAQPmpwgdVfqWGc8QdmUSwiHDCqRQr61tThzgBxwngE2MIC0VBMME
         sT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YCIM+YQFrajHkl7Ol4fId4ZkAJB6I0ksGBZA0GnY5pM=;
        fh=uaSh5TTI2cLCeEYNIynzBYQ8mJ2663DFmLC61a90TAE=;
        b=IZM6xlWkFf610b8Ci+TAA0b9HjZEMaybT/fDRBfrPydewUOvN7XSRhmpC9P4SpZao2
         o53JflgS4DZ4cXqzOJS8vZ5WsDay7+WwnqCJgBUq6yGy2lecigbhtz6Jjg9DCBNojMyS
         OmGIwHyQz+L2vZVogVYjpv6xr8MZg1mjI0cBzrJujGERI1MWzwIPi2dffCiMXthYs88E
         eR+vynhZFRvyAl+bmC0dQs89Jx8HvK8FAVcuPQ6D6HDixCuNZzfbzvNBGfHYbpRxqzZ/
         0lj/JfHLCSeRgbQDW0v6YaAbiamCL7nNAytXYZ3OWXfpSGuUKpETwhgg0g5bBe5gy9cc
         HlyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793210809; x=1793815609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YCIM+YQFrajHkl7Ol4fId4ZkAJB6I0ksGBZA0GnY5pM=;
        b=C6zJWfftH++Ol/Uc14Ra1quhlcwBrOkvf4AMz92MJh2e6O8gDWxm+r3aq4TeS0iTJE
         QnnCzb747IVf2cgaHjzBrK6KgXgm/9ZiNm7lN0I4stHkIvKhrEC8Q039t98mYiBYNyt7
         MYPHs5prexJ4ZNXhTAHcm6FkGOIgRaNayuRbk6/2VIadrObcAiwySzRehSUfP7O8M9N8
         gYZJwKP6ghz/lMPUw7/fmSl5GHHLVlcg+llIfTGAUIpJHJE1IpgvQ5nWRUCspSWh/PYA
         rQ0QW1fJbKjwytf296jDFo88u95EA3MlvmIfLuim9Crn3pgATV0LMm/Fl77HHozfCgzz
         tjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210809; x=1793815609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCIM+YQFrajHkl7Ol4fId4ZkAJB6I0ksGBZA0GnY5pM=;
        b=K7ACj0vYUj1xAlqgGLbk7/oyvAzFXM13SmkE8I7Wt9IxA0Jk+CHLntSDJV7gwkl+No
         CHmqUHeFFNSxAkkPcaTIsn5dfP3SLvgpFmT0Ncy2XWMuLgdMlYowoFI72Dft+PqbJcgA
         bCcMe9RmfX7DRr+FoCLOBSNvFjKHHRHOx75FmRvNU7C3Lcf6IL5QV19DjGdzB8LsX0A4
         tIrFYmnPyvjr6qKuJwCE0SwZ1CBFJruYpUWFcL5A9LJCXTDMhLo4TNdxRQYt4BLzPQUo
         7kN0ZH2cbRK83Cs5vr8wPRN8sgJ7MNqwbBFRGFz3orxFMrwedcmOKK1JGAy+eJ1wh38g
         eT2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1AtNda4TlD1nIFcI85pQ3W7k6NAzJ84B4inOzF7HJYBURJUiosj9O/dz+i5EDOZLSIUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqye6c5zuHBEG0kWaJ8mcx/DpX9keRf/gmrVJFnOfEEtTrQK2C
	Y38Pof1f3cOv1YypJFUqQQtcwEBOGiWzEaj3UBqI/ntRMXT+ls9CYo+1HG3BupK65FRFMPptTCk
	as5fa0+6zWMi8avHjqXnb+TIbAn27LG10Yc/Sjj0+ysaG43/iV3ho+8zwjHdn15pPnfyERkwRIH
	fJu0LQDNwG6ApMMECEKNRS7hEuDTon
X-Gm-Gg: AYBFou0ol4JPBXIXQWNVY7WpIDrghE3G+l4+SboheySlZNqIzRB9Gjt0t0BwPIzNKxU
	PeaCPPe1ZRfOEDa76s031/p/2mHlJrcXQGuPP/4EK2NTn0JkNMXoMACxWDumX7v7hIbhymPKuab
	kqBEey7m6FN+TQ8q/z1S63bZPw1Ybmo0B2SaloaS4hx9W3zWMFcY4SanmDhG4TGpdb7mOISkAO7
	k9UrJS3+55OvIwoYCNeN2A6jvziM+dTzkFMRP5BV9nZIBHmkqypTBVACUyG
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a9674e69dcmr70364575e9.28.1793210809516;
        Wed, 28 Oct 2026 11:06:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a9674e69dcmr70363965e9.28.1793210809079; Wed, 28 Oct 2026
 11:06:49 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143424.2732449-1-maz@kernel.org>
In-Reply-To: <20261027143424.2732449-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Oct 2026 19:06:36 +0100
X-Gm-Features: AclHuK9bNQt52dZaGcgL3nkbgBCrd6uMFuOFFsScp1NU61vx-ZKL1_doFNpPh7w
Message-ID: <CABgObfYonkEvFNzm=94UWCnH5h9Jv_FFfwOir5EAoaeW29eqwQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.4, take #1
To: Marc Zyngier <maz@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Mark Brown <broonie@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:35=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> Here's the first set of KVM/arm64 fixes for 7.4, most of which have
> been brewing for some time. Of note: a couple of fixes for mismerges
> in the initial kvmarm-7,4 pull request, fixes for the publication of
> IN/OUTSIDE_GUEST_MODE, and nesting for vcpu pausing. The rest is a
> bunch of cleanups for nonsensical configurations and some more pKVM
> fixes. I have already started queuing more fixes, so it is likely that
> I'll be back next week with a similar email.
>
> Note that this is on top of the initial pull-request that you sent to
> Linus, so hopefully conflict free.

Pulled, thanks.

Paolo

