Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125524;
	b=r4iGU4XvKGWgu9H5znCXNuRsWrBjhHai/vFPsV+eaFZ/rH779Y9NcaDAWnqZsxe92/hr
	 wtOtTnVelJ569rwjUnOwY2K4RTnqNSDOoObyaFwnSjt+V9QM7rFiwQWWW4a3a8wbQK6n/
	 HLUevX7MJhPNsHrkcqGnO0SapfwCXHmCpOOT8PLH3/9Cl7aX7Hbgm42YUr7U/4RMEN8HT
	 6XzeWGLyFBZxZb41oRHGhCqToDUZQ6qQ1i0+TyNdQsECzIsl2FyjayDEVO8S4LyvsYuOy
	 h57kQjHhBmsqfA6tPlN5rjSKRdNdoNtpshUch0c8gJ9st2z0FmNMr0AXx4ifdimfo8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C9ebDCpBthQgMMScktgvqBM0r+0RjQ/KSXq1saFehrw=;
	b=D11duheA8gNcGwpmfXWg9pUoF+0U4fUibdZ7wPRIQT+7edSM/7tSLHNUqdnlrn+dDpRE
	 0gEGKROKYMYi56OG+GAFcbePK4Q/Z+J5Of1l+fjXoE8ZrTw/wkpoE8Sz8dOAC2jlJ+hZV
	 y8CfvE77kqM00oQz2sCHcIDzfzZrmuuK/FhS33F96qjHLo2u9H6VGXjAbWxpsXxXpD1g2
	 esTZ3mLJQ7E9E/zrUWqET5h8rsYSB3Z956kkm38ba2Dz0vH979NMuHLiQChzbbELAP5Ka
	 uXycUJjkrFpIsD5PO/W7g4kT9tXgPVcdQKw1mY3Vg99+OzV6PCBviw4XZerXg8gaTqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=njqeqSGh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB47606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 21:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB47606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=njqeqSGh
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so4103a12.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 13:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795125522; cv=none;
        d=google.com; s=arc-20260327;
        b=WqZ0LOGGYyun8xIq2yMnnRINlGkTi2F/Ei9725rauww64ydCNJzLewnfkqARfTvATx
         NvefmE+zndKZRURlsHVUHxdcMnE0w9oD48KDP1MT1W30cTBWAkKXGKS5KRf20/5Ab+KP
         h7VuEvq0AoMAHkhCZrNueJwqgMZY0qBi2jugZVZqcqkDbKPHh1Qm6NcBpfpn23nIMkvD
         SxW1imCa0wamUVITFMc91AE9zhkm6hNDtQf6VHfHh5F/IXEERsrw3WgYqUizKOeRMhCe
         HzWhpAgfBi5FTBKMELbeBu6U8TdAtt5yfNhSKwLxDFrXTHukhUnMVd1hq48s+KIYNw3U
         eclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9ebDCpBthQgMMScktgvqBM0r+0RjQ/KSXq1saFehrw=;
        fh=lrYHIeFChdGnV7/zTC2rXaCbXq4W+AW8NNgX8A0DocI=;
        b=P1jkSb55oQxwVXUVOi6ocXs0gv+1j55deHDdx7EFRDMAD6CxtEFqTyHDwxVe7TgEcQ
         UeBSLEoVDTNjcs44jutbYYWxV8cGCRfR+xcvkqtzXBsWpqqfVQEXnzv0RdqXIJ7U663N
         21pxfnGAocH0Ty9HhjU2fAQviaZ+Yu3G0t1lSaCdfjZAZMmXHJEnm34nhZEvsEVn6xUt
         fIjqj9IvR0tkd1AIc1lBicxZEycIDxKohimzMpvQPRrSB5lu9JeAJtXXutSx1iqHGDRe
         tMrJdBnBk9n5CFBHzw2jjyDwXLyE6xdJXeirMgyw+8z7trVmw4SgAMXXIsm9z1gNYrUK
         D+TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795125522; x=1795730322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9ebDCpBthQgMMScktgvqBM0r+0RjQ/KSXq1saFehrw=;
        b=njqeqSGh6rjzW+SELuX9P314gQhFWBF9vyyY6ezpjF1hTaib56qYsSyRYkJ1t18EO4
         mOrEojR3dxUgEs3ntMCJAYuJE0yUBDzK8UkqzWR2Kc+7j/7Sj9ecWbo+9X6CzILipmQk
         iBh9Q4IELC6NmUXJUESoIEw4wZd8JGEtJ+z1/OnudS+iyVyP+3/DB7jhSDqRHk/Kbken
         A870U62wPLLh/osVM+4aDChvFf+FRir6ArwcAdYuNVCrTc+fAT5UUHJpZvbo5vmNc+8Q
         h2o2zIT8USGzPuZe0P3ohQzaBu+G//2I0oboy961ht6KLVlNAFzPYEEjJkc+S5zNcOlz
         Smaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125522; x=1795730322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9ebDCpBthQgMMScktgvqBM0r+0RjQ/KSXq1saFehrw=;
        b=Mw2zSooZ8wBSYTjLMb5XtEvbhM7NEBL0t15BfaGu99xjdzEikTUk3Ir2Qojt3jup6O
         eOwYC3d5Pd46glYh5KRjqMpEA5mepINMHGFYz3QmYfN3DzQ6IvVC4Qm7s9aUSccWyQ3d
         pTkKSJZiQl9GqcrNHHxnkzAmUQA3WJpvcsO8AD5BDPE9sVmhSFIBojbobwWLZqaf94us
         oHkjcmJ7tf00tJnzxMnfPWGhVrQ9SA+09SWPir3dOIx/lEZtlRVqPWBRFPBsTHwiSp/9
         k8pD4/aldNtClUFIL6MCxhdx7+p2S7z14pkqof7Zae75aDiVbYOqB+avM4jA5NyUAqKj
         S52g==
X-Forwarded-Encrypted: i=1; AL+hErHOMCSM/9DgTBl7bQiYzp81GVJm3QQdKqhJSVnCVBc8yrJVRX482xV6PD9tiMzI2msIAj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/C77PB0NBF1Pd+qcqPMb1+9a7m1wSiqXxcwo2nIoAPMJW6F6AV
	dU9YfnEfveyyz+52/SXbjtUx5uZEiB4XLvUwUVwyWICi7AF1R2IBNllxWYFuVxmJuz6e30lwUYY
	kY8k7HQIcZND1NP1C/NPfsOu1FU+mB7Gep87rPVTC
X-Gm-Gg: AYBFou387QUgD53M6s1YsUR3f3LjTQiEG8MmP3bY1H5sI4I3f3f7T+FWnyiGpCi2BDl
	TfCPyj+QL4FkXq6n6TIey9J6PUDlN4Q67yawROqd8T4J0KHsLtmkGrV24kLcO4YEjBWkRVYMEbf
	4StQixNoc0C5SnS46Z83g+cihDiSqiSBq+Cqupdtt7XOfFido5iV6cze5i53HdKdhHCRa02f5gh
	QUinOTxGJ/U+muqse66gZh+O6hYbKCuIKQuSU4a853IwQx9EvxA+RjkSoHYSsiso7VPryVtmogy
	6TZkcy+S2bV01TR/Lp6JJ09km7bK+UyJ9u42nDbuQuMVhskUpBaM6/+I56LryWjYPka7+116KiC
	BIeSkhy3K0mSS0ZMEwqb97Is8V71oWqwtvQ3pQJsj/lOZq++43TTuX4CgGV0HdeyIN4s6nfQSqB
	xAReTVFhURi3a94D6b7iEoUTGq8GnhNRA/a1+MDxpCsV64WdJa/qqVrA==
X-Received: by 2002:a05:6402:c4c6:10b0:6b5:77a4:e7c9 with SMTP id
 4fb4d7f45d1cf-6ba38153010mr27681a12.2.1795125522153; Thu, 19 Nov 2026
 13:58:42 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-8-shivansh.dhiman@amd.com> <CALMp9eQmOcq0Edb6Txfe1NPASbY=3u=NSkQrVAbtqtecr6WWqA@mail.gmail.com>
 <cc34f113-d67c-4c9d-875b-5f44ccc5c5ab@amd.com>
In-Reply-To: <cc34f113-d67c-4c9d-875b-5f44ccc5c5ab@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 13:58:29 -0800
X-Gm-Features: AclHuK9Ty81194q1WR7jKMvgrsnHWSR1mIt9uEvg-GWj2iIO-RiQZ4F2M7CLysw
Message-ID: <CALMp9eRs85yTG-wgtv2S+eVCwWt2SmjH4OAOPm5cQjQB8yv9tg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:42=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
>
>
> On 22-10-26 05:19, Jim Mattson wrote:
> > On Mon, Oct 19, 2026 at 2:08=E2=80=AFPM Shivansh Dhiman <shivansh.dhima=
n@amd.com> wrote:
> >>
> >> Now that LBRv2 is fully virtualized, advertise it and report the LBR
> >> stack depth in CPUID. Gate the advertisement on LBR virtualization, th=
e
> >> mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never expose=
s a
> >> configuration it cannot faithfully virtualize.
> >>
> >> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> >> ---
> >
> > In addition to what Sashiko said, I think this needs to come after
> > patch 08/12. Ortherwise, we can hit the KVM_BUG_ON(is_sev_es_guest) in
> > __svm_disable_lbrv().
>
> Makes sense. In next version, I will put this patch after the SEV-ES
> patch. Thanks.

Please put it after the nSVM patches (09/12 and 10/12) as well, so
that KVM doesn't advertise LbrExtV2 to userspace before nested support
is in place.
