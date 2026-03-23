Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E392BEC55
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268547; cv=pass; b=hIEtAkvOjzM22239+JUuW3w8hYdcwDMECXyBam7cXtqYAAfTAbNloWlU22iqka6f01ajyoQu/K0V6b6HxksNQ1Yw3LODlq7A1hiIaui3Se5qn0P19HawMvVofO4Sh8bz7ahkyzBocPFRECqBFtgjtf/FQhKlaVk1DFAyx6RC9Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268547; c=relaxed/simple;
	bh=LDWNC2EdBw3YFEuTUDVzmOsNfA1PIhCdQj6JkWa2A7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEYQ8k5waHKxuWB42dmykM2IdEZkrselEQQirlfFz3jSiVXpGB4XE5x+k8nROM3gj97WapNd7qZePf2k0Ivq1TK8hDsl3VxbgdhI8Om/rYgijv6iJb+pXBYeNv2CQRoIwjK115ATFCnaLzM2VyYiAHrLPtViDjIGkx0XFL0ZTlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jaja729l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsccXOUU; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jaja729l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsccXOUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774268545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWNC2EdBw3YFEuTUDVzmOsNfA1PIhCdQj6JkWa2A7s=;
	b=Jaja729lo11O+HVzvYE1KvKiCJmrDXD4+Swa2kU5RAfHD5EVrXnwjTqOaKutyrzBaJzaTR
	neOO7otBAx3Wkss6Jh2gzXnGow+F5YK0cf8sXgwvJ7HlqzlTYU0TeMmrnafbIcyMx0bPKx
	rrs+OGag48XySuELfRmZyelQLu5+ZY4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-2j5VZ7_5N6-Qd3D2UpA7Dw-1; Mon, 23 Mar 2026 08:22:24 -0400
X-MC-Unique: 2j5VZ7_5N6-Qd3D2UpA7Dw-1
X-Mimecast-MFC-AGG-ID: 2j5VZ7_5N6-Qd3D2UpA7Dw_1774268543
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b3011be7so3596290f8f.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 05:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774268543; cv=none;
        d=google.com; s=arc-20240605;
        b=fLykLz3Z1Ek77PgaZtCFy3lT3lLg1F3GoT7k8fqxPjKj8zTcoupLqSmlTDRAEvM4tx
         eAH7/20fRhXwDrP3GCiSiEOoyryzf9Jd0so+1ZS+tII/4e648Y79auJcW2c7TRk2y5Tv
         PvQce4C0AgjGsYIbIk46IL4xdsTsnHLKChdT1NSyiq056a7urn/17CpW9kXUMwICfzbc
         eOzIa5lH3M2vgUK4fy5OyMc83qoMQGeI6cPShI16XkmET+CK3EDGNgDQW9lhPtyjKlAX
         h7dI8EmzgTtFHGWz5pouy6NOt0KmKAL148mr5OIDppOq31xDSR4+BsYLMoApCd0vTz9h
         IN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDWNC2EdBw3YFEuTUDVzmOsNfA1PIhCdQj6JkWa2A7s=;
        fh=f+slGUSTpeiUrgOlpM8mPQxm9hZWXz8R7xgf/RiQNuY=;
        b=jxrz+JnSm8tao6ePkv8WwfmjN39NctXijazndxKM95jeVKCXaYVAH0Z+75G6hUXtwe
         AhyUPHQW40IM3W7e5ndlVac5NarVaKmrfmpCYi/IkfGymQUqF1pcx4oYO6YnbO8ogUPc
         PRv16evm9a99EovTmCIf7turPuWx7wyvrEkTlMCfpnZ7KMn0NsndkxoFWbYMniAIkdzx
         0QxOW5GRCVEnwzyKwVv3DfDdoyQYr6usCX7KXh8F2yQ8V5Tb66BGG+Lw0V+WUk3bvYYR
         NveZ6AGzgnv2mNxCm4FFSLVl7FZ+FUlyEievzA8vLQUimttgFNU/zc6/EhxgtI2jVx8c
         mung==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774268543; x=1774873343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDWNC2EdBw3YFEuTUDVzmOsNfA1PIhCdQj6JkWa2A7s=;
        b=HsccXOUUrCBgza5N2zktpEhFK6hMjTTqLpBpdUQhLnsngYrw3hGhxNgRw0f9sMzTSR
         ZCy+lZdQp2ENx32ITINHVHtoJQyQH82g96XSDDlCphW5VVZCniLt0WJHpC2QzEcr+HZ6
         p1uVDBDcj7v7JBXnty13TvMz4bntlBIsTxIXJHEzuCRI/xCnVi85W9BcjVxFL3ZAhcGx
         B85eSrxzGWSAodvVIHvAJpZOxPLIDrhncvxMcueeKLWPdjI+YGC+cnNPkWhEOp5kx6Gk
         nybUdV7BRNr/vK+Lw6GdQA74PWtCjnJWiHLXXty0E1Hx29MTpbmChgoW1sCROcR/IsLG
         AKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268543; x=1774873343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDWNC2EdBw3YFEuTUDVzmOsNfA1PIhCdQj6JkWa2A7s=;
        b=sT0//fhTX+cu7lheVioUbGHIODSVcXfpIyysEKGLSRRsVNVquxljVhoORB4nqizvgz
         cRJ7Tlljpis3Ll2HKLoi+mExwX3GGMzfyqQHkhPFM9bbdnQ79NYnYY/wLGgg83m/MQ33
         +dLenDEKzAB+lLsML83+3/rCf9eQi/QrjBoMzXDtuGjScWSzkoE9IFrTbYxFZLZ2Wkyd
         JSy9OnOCHH+m8iKEuvhKv9zadDi9GO+gBI0ZCw7wDiO+mqTsZTAhLx6Tn2XP6byc6szT
         U3C5UU0U3LvsKuz6PqXjwa6XYgnGuQ3eQuWyMrLZrDVG1KxVCvBsaftkHtVQOAALHgO1
         eE+w==
X-Forwarded-Encrypted: i=1; AJvYcCXaK4lvxfj6NMeAldWx6gx3njmylHAh60MX7/iIfBE/iVsBd1io1oXJWH3+qHyI+oobrBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1U63l3kE5GyytJ2sJPtOuFEfmWvAE2amgmv0EEDeUgk7QzBEh
	bqiPE0+AJARTx2WHRDDmSlOuxWuADMwRrukxBg6l5m7Fyxv9IY8oANjqEs3cVU8M1zcbGgau2h5
	Udn7vBgLNEofTCbCuThHWO7xEhdM8ThvpTi5j2UGNA2QF2K1O8wPj+Qc7YK3StkyzKpsT6HdLFz
	kv9/XbB/sq1RM5Re0SHgNz+KiPd3ni
X-Gm-Gg: ATEYQzyCkMXiZ5ALItQ4BiTogzPp7LEUygypJYE3v7ZM8lfh2HdtgNaJ+eZyi/JpTRM
	LDEDKN3gKUmrAkqE8RaxatDvtT65hpo11GOQ3M+mEIy4mWZlRrk0YdXfEl3SOHygzq6U4NqM3Mo
	G6Oh/iYpS8tufC+nbXdDPGM5V7klaiCS0BmSn2T9yjNrEH3Tr0RlgvdwiTbBeUa1q58fPY4zBCD
	34jFq4HJrJ70Y17BSX7ASiisTuI9UY9ACHmzeeaqZJeoJDYU0fLrO4PAvH9irJaeSer329n/du1
	JLfZ
X-Received: by 2002:a05:6000:4381:b0:43b:62fa:e3f0 with SMTP id ffacd0b85a97d-43b6428ba76mr18389476f8f.48.1774268543232;
        Mon, 23 Mar 2026 05:22:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4381:b0:43b:62fa:e3f0 with SMTP id
 ffacd0b85a97d-43b6428ba76mr18389424f8f.48.1774268542722; Mon, 23 Mar 2026
 05:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local> <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
 <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local> <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>
 <20260323121708.GAacEvRNp0sFRf8dA-@fat_crate.local>
In-Reply-To: <20260323121708.GAacEvRNp0sFRf8dA-@fat_crate.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 23 Mar 2026 13:22:10 +0100
X-Gm-Features: AQROBzAxahMCMQbFD7U62DCqVRJ7ndPhhvo-q4tpOjlj93knviEbk4cFUwOZyDE
Message-ID: <CABgObfYsNhfCpzoNP3bZaaS_AfhRwk9B2K0j55U_GMzLnvJ5TQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
To: Borislav Petkov <bp@alien8.de>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:17=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> This is the key question: what in userspace is going to parse /proc/cpuin=
fo
> and look for "gmet"?

To be honest probably not. They can open /dev/kvm and call
KVM_GET_SUPPORTED_CPUID to get the same information.

The difference is that /proc/cpuinfo will always have gmet even if the
module parameter is zero, while /dev/kvm won't. Based on your other
message, it seems like you want this to be a bug rather than a
feature, so let's shelve this, can you ack it with "" instead?

Paolo

