Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C329D27A
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774240188; cv=pass; b=dwsehLmqU559EUKUqZYAsz5La0cVCv3Kpygt8SC/eOhjlhkIidoPOf9KkcK9vqH72aO1nGHJxgxz76H/m1PkQwJF6MrnryjGMxCuTsQ2qYTUujqbTkp7j1hpJbYb95ZTuwI75M9Ap5M/dm+4JdJh5oWPdSw7+ywFi9AjEAqHstA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774240188; c=relaxed/simple;
	bh=1/rcecgLtux8bTAmuiZ/+rML+Ha5uRoGH+ayUHLvCcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/lh38cxWHQojSxD/D3Q/WhVFZhplZEf6O21Oe7GGyzVbHAE2zsv0Z12+OgLMlyVawzaAcmaUa9/6++gO4A480W0B1vpBDsy2h7sPHBi6jXD3ulohX6Gr7ddYgpancgGf/GV+7SVhUYoOCUvR0WrLmdN2skbv8Jp7rl7tswaQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVuhJBSI; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVuhJBSI"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b30d61be6so1155661cf.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 21:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774240186; cv=none;
        d=google.com; s=arc-20240605;
        b=jrtAyYOHtVVhBFRzrH4H28DnDFBg4Pg1gBVLETh3IqcLQo1/EhpbjD7F2F9fSoRdys
         MDlSPt4vujkvL7CDPZt0L4L3IbkFgkx2AKHaivLCbTk7Xy/a/HGZi7qRpgVvsfj3va4C
         ZD8RKW//gVkDZMyN1DSEZDS3VXCJmqFuE6KB1h+K0pg2TSyME4tN4H8fw93EPFZROhEj
         oHuLHOd44wXSPCiOdFw3mzpK6oR7Gvhl8X18X8P8uVUfnlDhpCI9zgzSlihs0ypc6vks
         i+NRuNfyhRcwEiMlFWG2yc151HS3+tHIT++P6vrJAEVrBSZibG7kHt65uH9xaityZBK7
         HBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        fh=9IA4msGWcsRDcpkSMLazcdeE3NUfHa2lferUZ+aVm3o=;
        b=IiVVn47EFF6O1OUDp2zoIkG/7BbQIN4GC1RzQsyanP1Co+G25wzj8iUOur4VddEp6P
         yWs9uAPCyxli6fu63WB8WYiqaG972kQrhDudj6uil9NZbAqoIu/7zRfKJCel5T5CA8Rs
         koYppw0T4QYJO7uZcFYw3n+gEG9iP4AI8a0cEjOzK9uTL9WaOJBqXt4Ia6u85bsT7RFe
         tmZHxW/DgtXZhLs9AJe+2r74RLP7TCDflCI5gf3sL3+OY7/WeVsZkGe9Ep9zLZi1mq5a
         /qphiVrFFP92YdRrBXaE//HtF4ff9vHqDay2aGsRhDXLQ8U0Pd42G2p0ifNhpJLlN4VR
         v/Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774240186; x=1774844986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=kVuhJBSIHN6zhN76IpzdiXj1eZtUbDCbzZQYJjXe0/t06/meZCSwC30o4Y2U0RIowK
         9u7J6BPW9L9HadxF1P9Mh/yx3ZAUEoF6asfP53NIZQz516AE2JVbl3wbYves5F2wUPf6
         saIwWusyz9dZiDF3b66l6nvD0pHATJ0RslPlU+A6uKZZzmdF3YD2OPkMmgZTDoQLw1aF
         PrxnKeeEJWXGbh2MT3m2i1k0QE2u/z76O2HcgwVP80rJQamZaxuXyViyrue/Bmq+lANi
         vnU1aWe83Gm3anKQBV/Qzo5Gp8zzeY2IrcE4LT3BY33v6YDHKkHWBEnUcgFGk1/CgUBN
         w6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774240186; x=1774844986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=VfKvEufrAi94dcqqlE+CAlq4QhRV3XBk+LgbZhrQLESYswi6IjGgGXClkp4hHUaYkx
         2yI6Az+bwKO1Fkbapk6wwDc/97kSdTa9Pjq7Xsl/wg4z23Iu17dlBC9tJOaqSAdhGSRh
         p/ZfvTPX/kv4Vz8SymuBBMZi2bUXly2kRv4s/Tb8O+qTM5/zocSw3yu/h16l4AllgNbU
         J7VGTSuQ410UPMhjmQdZWIt0gVu+h0e2bCR82pCWaFWQd627VmlfzaB6PytnCOlJcu2Y
         AWqnWb1K2f4xNEKzfNCZjkmFZDpJl8+eTeIzsYaL2QjEEkgkelC7oKp2DUMKxwYY+Lf1
         EYQw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQrPWX1IWTrwZbgrMBHN/OqqvLmuvEbmNg4bwqrgIWeODmNPxCIcYaLg3yXZjUMI30YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrj3mi84ytPHiRvmWQXE1/2Z7LROu3JJKsGtsEH0ekvnJABux
	PFM40l24OAG3KIxk9QCyOV0wsE59Lan7bTtj6xKXWrwzG+FB/DWeSSd3bx8mMQxer7avhnvFBSx
	HY6KEQGN+lpiiAJX9tmJJ9BUk4C0FhcKDq8LOV5f0
X-Gm-Gg: ATEYQzzWuknprT+fGvIybHoU2FTF2nhWFSTeuxfNE6WXF98BLlTTBOVtoK8+vvxslMD
	W8hW0M7MracZ9EeoykvPhLKLS+F8XaiJidel6xeO1MOTIjQ1+1VRK3rJbbuWGSIpXhZsOcX/mGy
	rDJ2jLAQtF/7q/CNpTrOG1e2B3+0KQaooynUcN6VrU7Ti+e+UQyVZjgNEabfcLEjQTVXJ1vEOZn
	7TDKV3t7vB49GLDNZLr1Yck/dPtmAyu0qGTompJr+6HRC4PZqYUg2CrmSsdNUrHwdGYEviiHaUe
	NcTtGg==
X-Received: by 2002:a05:622a:5597:b0:509:123c:f317 with SMTP id
 d75a77b69052e-50b46a6754emr23046811cf.0.1774240185749; Sun, 22 Mar 2026
 21:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
In-Reply-To: <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Mar 2026 21:29:34 -0700
X-Gm-Features: AQROBzBY2-_fJYphsyTdxWc7XCwazEP7y-d_Omc4v7H9yVwU181BEprIAh7MNYs
Message-ID: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
>
> Thanks.  Sashiko review raised a few possible issues:
>         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@goo=
gle.com

Thanks! This Sashiko dude is good :)
