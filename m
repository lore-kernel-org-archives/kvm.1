Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541475;
	b=eZC1DbRKvk84TIpdHS70vORT/FoXRGH5hA/R6+D/LnekAHS91iugcDXLatN6HLyGQ6jF
	 tjdQEudlFX4EikH80VU6vBBYKxr0YQsG50gCZrc7ZrHJDfWALlGuls5d0gjsBS8STIHv9
	 YkZ6QYfOiyL2qACQXDAdqBiLn4LuL7rHYH46F4XtjBMyLAu/CYQEI96tuknci2swcg/6a
	 MG7xj0T7y01xOgi3K5mKMcHkbOVJBh17I93x3m/N/hVUvdpU2DA6xrLaRXDhmKjf5+dbj
	 XlnSAFp3frx9RguVmzRxiOxGJnh5xEJmii2eRnjE/T487CLCix9QxUYoJoBPg9LKYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541475;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=RpUbfWxz8pPyPWO3yv7OZsnOJtxcXvcFltLPgKWaHpU=;
	b=WWhDyCKbchbAQluihjuYd0NrRmGZcqIDOPTpG2tj9d2p/h9jk6phYPwVmfPl9HHUT9I2
	 EpSR2FU5RQGnFm3iLjW/UtCe03TrFNMdqUFZXu1GPcp7GTDP2f86S+qxgQRWiU44/m0ge
	 Xt1/OHqPNagGYuQfO18OSJNLLXRYDbKakOD8MeP1Fi7p/Dq8vI3e8PVaCiLQf3I+0vmYf
	 UauwhD7WVvLSlqKl2QkbOT/bNazNOlcos+pvzhovwZ1LjqtYqXZI2Jkv43ofig5EEXEfM
	 fsg1ES4SyaYeuLkQgjFhuhASJWqI4vWZ7WHM/f/imiNOxGjKs26fU3SJge5J5X41agQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JsW4r4lb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nPsTnwQ3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7C606A33E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE7C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JsW4r4lb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nPsTnwQ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795541473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpUbfWxz8pPyPWO3yv7OZsnOJtxcXvcFltLPgKWaHpU=;
	b=JsW4r4lbhPeV6l7bWZFQtrEqVTH1tdobrOH+bTwCF2r//qLnTuYjQhu4O6xKBsxDULDHsS
	BaTA2DJVZru7TbIhTbMGi9nOBZlIbD/P+eiY6O3w2YW7PBtzRFlYRROSSG2w7bdokx1QjL
	AYL1KlAgeUmVbX4KXLk2pE70ILD0GZE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-4hZoPgwvMzu95C15nvvOiA-1; Tue, 24 Nov 2026 17:31:10 +0000
X-MC-Unique: 4hZoPgwvMzu95C15nvvOiA-1
X-Mimecast-MFC-AGG-ID: 4hZoPgwvMzu95C15nvvOiA_1795541470
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-949dc497896so303981785a.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795541470; x=1796146270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RpUbfWxz8pPyPWO3yv7OZsnOJtxcXvcFltLPgKWaHpU=;
        b=nPsTnwQ3cm/N5OmqdQGXETZrke804i4d9VBXa4Pfr/69qGjuIv2Kt/QKPud3QnvYRB
         Yfy+Ptz5z39Uyaf/3NMN0y9C6W0s7UsWr1G4RHt8nzrzfeuMpDu2A6zZYNHAgKZTG4xr
         VQ5OzB96CNkZztQGpX0KPtREFK5Y2HsbsAgGw/q2WR1KVx8zTed5iclOIapOelXT4Kgw
         vGlxbaU7z5r7mQKEEEOeNEkG286k65qPPTw9NyLYRSt8nWM4vyQw+nAVUTloIuRA7rb/
         F6np0g+8zSHziRZqiVf3N9o+47wEgv4c2S7n/zoC16hvRyLQNZs0JtmyyYy/9tJOCICL
         iQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541470; x=1796146270;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpUbfWxz8pPyPWO3yv7OZsnOJtxcXvcFltLPgKWaHpU=;
        b=DWzrZySaSkUsPX7Lv6eOd7lkTw+/aKYnSfuFxn2s0CM/SxB51NDDa57R290g5LdRHH
         Ub9rZ6d6pIeP6z+3On7CfxloSXx5R8TV8+ygLznNgD3Od8yoxk2V0rsrq8U6ctO6xNtk
         Rr8N9YXG4EtQUjVo6BgPLbdwGhsiCDQlFxktJ5oj2RpbJyAT72GL9XJX3x8uCBFQKla3
         UXravu7Fr9z41esGaGiv0X7aj5UUi9tCMmekb1jgioP/q/Cd7qU5of3E9PpMuEuExfot
         ljYNqMbPR+FahWfngCeSuuhMdDkRevC3DsQRSipAAkPMrqw8ExtZDcHmctRXihLpv2a/
         M2ZQ==
X-Forwarded-Encrypted: i=1; AL+hErHpoCNNlNGC+Wk3K0S8iO8yoELLkn6U6acQmi9fkNjdth+2UnQBcR61781A67Z4lAu/Ehk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oJpibvxLHkb18/utdjDYqpKAix9YtLchnVNX0OBvgMuClpjIm
	cFhfKS/yBryw3AIGlsi6fpO+PqR05wPKQ2cObe764dMfJ91raOeZdRUhPhrs4AO1YTVCQv0kQ+Q
	YqNJ01itTkw6+v5YBvzyIZR6y4kk1tQ2fJWzEQDNYV2jCyy2SfN9FjVvDCxmowQ==
X-Gm-Gg: AZFdTZfOQ1XyY1xIQO0aOGgtrC34ivLwqNdp0TkQSkJo9TpY5zVgPOMK4iZO0mfGsVY
	OT1pfxb/rBj6Jtm2wk0CXOuvMoJuGGzHqJ7WTK71uYV7xcBj3XKaepRr9+fpJTWFoSKOszUr2hh
	aNpztIIaAJQqb670xM/9KOPaNrH/IrJ++iXBGmdSg3RmtmvIXJx2ipIGmFskL3wgvyBNBjQw/7f
	FOpZFf9To7m+sNixjDqoHJW+1bRwEzfziO6oJYWc/cEvXq/XOegPLV5YnECcw0sUdujKIYPoQX0
	k8HpX5nFQQl4BFrYOXiiTTZvVXVjFIGEw46XU/Dx1sk9pdIk8m5oOdRU3enRji5IIPDXvq+fW1a
	GpH4vidKTIgLpcBcHsX2JqcihBWsNAEKMpu/tCEvq9irM/QI2lL4gUuxsNDFkPj3TDrX7BorR1N
	nI59crAo8=
X-Received: by 2002:a05:620a:6485:b0:949:a71d:af14 with SMTP id af79cd13be357-949bab5548cmr2338609285a.66.1795541469913;
        Tue, 24 Nov 2026 09:31:09 -0800 (PST)
X-Received: by 2002:a05:620a:6485:b0:949:a71d:af14 with SMTP id af79cd13be357-949bab5548cmr2338605185a.66.1795541469382;
        Tue, 24 Nov 2026 09:31:09 -0800 (PST)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb ([209.103.33.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb35005dsm1093771285a.11.2026.11.24.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:31:09 -0800 (PST)
Message-ID: <810dca21de79ae1df524c45d920933d8e2e1915f.camel@redhat.com>
Subject: Re: [PATCH v3 1/5] KVM: nVMX: don't check PIR.ON when processing
 nested posted interrupts
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Date: Tue, 24 Nov 2026 12:31:08 -0500
In-Reply-To: <sashiko-outbox-229790@kernel.org>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
	 <20261123175512.80438-2-mlevitsk@redhat.com>
	 <sashiko-outbox-229790@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 18:02 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] KVM: nVMX: missing Fixes: trailers for nested posted-interrupt
> =C2=A0 PID.ON checks
> --
>=20
> commit b99242cc2d5d177888bd387559bf392b46fc1d67
> Author: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> > KVM: nVMX: don't check PIR.ON when processing nested posted interrupts
> >=20
> > Despite the suggestion to test and set the PIR.ON and avoid sending
> > a posted interrupt if it is already set, there is no requirement
> > for this bit to be set for posted interrupt processing to happen
> > when the target CPU receives the posted notification vector.
> >=20
> > See section 30.6 POSTED-INTERRUPT PROCESSING:
> >=20
> > =C2=A0=C2=A0 "The processor clears the outstanding-notification bit in
> > =C2=A0=C2=A0=C2=A0 the posted-interrupt descriptor. This is done atomic=
ally so as to leave
> > =C2=A0=C2=A0=C2=A0 the remainder of the descriptor unmodified
> > =C2=A0=C2=A0=C2=A0 (e.g., with a locked AND operation)."
> >=20
> > Apparently Windows' implementation of APICv does exactly this:
> > it sets bits in PIR, without bothering to also set the PIR.ON.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> [Severity: Low]
> This fixes nested posted-interrupt processing and wakeup checks when L1
> triggers the notification vector without setting PID.ON.=C2=A0 Should thi=
s
> include:
>=20
> =C2=A0 Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt pr=
ocessing")
> =C2=A0 Fixes: 27c4fa42b11a ("KVM: nVMX: Check for pending posted interrup=
ts when looking for nested events")

Makes sense, I'll add this.

