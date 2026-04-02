Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F37388E64
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116233; cv=pass; b=MrLESn5XA8FH1p97jwxaodujQKmlnItkAXCtx5wKokeW/1w1O0Jur7n/eMsJnWuNc0YuehN7x3egywT3HQZ4qMtXMjNINUwiPpXGWnH83y/v27o1aQAT1xdQBXYz+kKLkDh5UlCQetkwwXdtanii0fxpjTxUV/v3Ls4k3RYtUQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116233; c=relaxed/simple;
	bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2oZ2Y8Ws2AUAJS7KAmq9jfQjBFnE3EopfXkTQHOmn0Da+IHV2xcCw0i/QuVH1CVYtIN5QT10kOCeLP8LG91yr/qIFgg9YcQl3YkioN898sLsD2BTQlDqSZ0C4lr+aiTtamCr6NJwsLBAtPFbcQgVC7G8CvZSSANoCR1MnveqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpAg0GnF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=emzyjofX; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpAg0GnF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="emzyjofX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775116231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
	b=dpAg0GnFVQ338vC3kngyAD9Jx2MsbKn5OZg0elY3y/j+LjvlxeHm9hcSPT0F8cg8Kwwkmp
	//C+MLSpuaSa7umVof6vYjiTAY9AzIk5ByjKC+1R433LwnZzrcZ2kYOKN0SjB1K8BD7WMx
	UKtn45fRg/r5tm1T2qVEpoDzKDCI7K0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-2rpSAaIfMc6UK5FBciuo_g-1; Thu, 02 Apr 2026 03:50:28 -0400
X-MC-Unique: 2rpSAaIfMc6UK5FBciuo_g-1
X-Mimecast-MFC-AGG-ID: 2rpSAaIfMc6UK5FBciuo_g_1775116227
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d0c06c232so563132f8f.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 00:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116227; cv=none;
        d=google.com; s=arc-20240605;
        b=S5pvKZSPzB3LP2TUsclh9g3Xy1eBXS/+8CbxXBMxqP7eoG+RG7q9VOvSnq3EVWkfok
         vGjgx/wu36n/o3mwoVFByiOUqPzYSRJ5m1jEXrD7LmYRTn2rGIAgrYtpKG/NZsXkW6UX
         5GVwf5qvNDOUrO6ZPKB7Mrd3PKcTrsT8VtwQIPXa2iQLfrhbxxDvfwsNYAOoSopH0LQ3
         YoOvTNfuTu4ll01oyX7wC1jlzmJZAGnSjKX6sKgn2BZ+ReDMotuIv0zCCzKQ5rb8Vkm/
         DP/rXwn29GY2PjyoViUbLU9YCZ8oYaaE0ylFkxPpblq0YZDkDy3UUwoXUboQjtUkFETw
         aNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        fh=evXgshwIft+VmJLWT6vijPBYOawUO9TP51lZOYVds7M=;
        b=VQU0qJSPwUayp9Q7+zpMdGhSq2bYallyP4RU/DF4sv2eN/n0TM79nqOncxScGJzhoV
         sXVOZqZ8EAbU/ZxIby7/gt+T/V/p8mlDqts4t+FXP9ck1LAWfOys3IyAv2wBFxgYmlx5
         xL011bNqy5EB1gPCaRTB7TO40slLxu9OME0MUaRgiowJY3TPDczFrRlKOb5G6Tqp7QyL
         cF92xVBkGyrhKRZrw/OWnB3Da8wWgLKWT5RdhPsuUscyxOenRljME6qbOCg3+phD/IeG
         nXOqf7UYuWxNw3ElyPH+d5LBtxDLlNOnS6IMmsvj9c2fa5nG8FkO4uBgJE3JdYUyNM5A
         LwJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775116227; x=1775721027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        b=emzyjofXilzMg1u5dVyR7UKzywnhHYvZHAG2ujeLwD8/jL61tybr78gS0hOGWnhuCQ
         UgHzfQOBbmmGBdNAyOg40Jc963bqYwdageHFoCRTHtyM4aHRwYXch6CtCF08faHkgHnh
         ZMiAVmvEeqsC8ye1RrM0TFPsN7j18aPPZiDmWhbZWHVp4oj01yZd03UjoY+G+AaP+Z3r
         Z+0xq10GSkBIxEzvM3MZ0HGWxXeM5C/xjPgs+YOxJBxA3UPlzqshD8+1HJ80Tn2N4zu7
         mgXiYm08cNC+Bjs7gAagG8OOmn0TcC8i72j3aH10d0CRrqF1lXyfITkbnP83Sdfz+Tnn
         YrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116227; x=1775721027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        b=A0qLD/ekPxh0h+y0AiGqKap+0rMUQrb4He6fwJQxxY2IX9qectfvrrFD7fAJz8ifb8
         tuBU5DB1mmo8GZ0gxvyq6TNoJzvYezPOXBT1gRTFQcojrYBTHCNhMk7BDHXVMdy6XqyN
         sF3CbYY6M9nWMClv/nFfCT81hGdFDDjXJbTP8jd9Ku+pw7ORA8iuZX06jwnUQ/ebZbio
         Xcw0iIMrQIX04kLEIAenBziO4uIwaGaOfAWp3jduKMHKNo7M3Z3Z6JuU9WzFiNzEk4kh
         OX/pMh1H6eG9oDmJ+Z9T/Yxn+7uaHGQnbSadaMwgu+ol+xOENl/DPdgUB983GhCW5jnF
         2R7A==
X-Forwarded-Encrypted: i=1; AJvYcCWH32v22H2qLErKiuna2faburv01zCdLFT00++dnRri2g6mh73g40XHMqTHV/AlZ9SHTas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mBWI7j7QOL6oJU+hd0WBpDLn9JwRdZugW/wSwaHkvHkTcaYX
	nXdw6eiIRmzJSdayqN8SKKN4tYAsP0Gm4MT5dNaXOeyBqiSvfBAKcIho671kWA4mjSaPGLXRXXJ
	3aWszFKFu2OfQXJ1WxOlD+xNGTX6ooJXpIYvooJ7m6cPzOrKgKMSlChxrrVblIqbG00alflmhDv
	Fb4CKlcvX9Cd7oauR1z2Oo0T4R3mtH
X-Gm-Gg: ATEYQzx1IeCmTXrBEiFTQKTqqIEWD6JK1q3Km2BGvu1ehyUMjoSRDt5TRbsNl4NLTwR
	aAYxALTBVU5+uLIizz3/BZLQ1rEKNOPEzYxKyDVZ4dqwoq4PWKb2mCq1oPMD/4YuDjKt1Rqlqd1
	lJGEH1i4oGO0EqcbgrFhtOnZSyWBr+yKBUm5dsx7rKTzTirKp9kzPbCM/bh/YyyXG6WQgFUxQlU
	lHML4OAYD/6t4MIY+KBCUkdkDPP7GxYYwgDCZdYUcybVaSqcdm3jZvBTlb9cOTqInPXdoo5mR4J
	VB8d
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id ffacd0b85a97d-43d150f704fmr12485811f8f.40.1775116226959;
        Thu, 02 Apr 2026 00:50:26 -0700 (PDT)
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id
 ffacd0b85a97d-43d150f704fmr12485782f8f.40.1775116226538; Thu, 02 Apr 2026
 00:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com> <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
In-Reply-To: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Apr 2026 09:50:13 +0200
X-Gm-Features: AQROBzDbo_UB8L7t9EPUKPw2yAJ2OO_yY6p1Y0aGStcwdRXgVDozYg2-lZSXuhE
Message-ID: <CABgObfazpG=V6rxn-=6Y2rv24zeMhK0L_AuAtXaHGXuMj5BnGA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, 
	kvm@vger.kernel.org, gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:49=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
> That being said, I personally do not object to LTS-specific patches
> (e.g. like the one attached), if Sean and Paolo think it's worth it. I
> don't really have time to do that, but I can help with reviews
> (although I will be OOO for the next 2 weeks). As Paolo said, be
> careful that some older LTS trees do not even have the cached save
> area, so they are broken in a much bigger way.

After the merge window, I will reevaluate submitting this patch to
stable. But that's all we need to do.

Paolo

