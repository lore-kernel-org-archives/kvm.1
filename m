Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDA3A8FE8
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386615; cv=pass; b=hRZ70gOW6ry1idTyjEbx49l+xbnjtt94mTw+Pd8A5Mvx0je8osjDoTkKmdHBVsPI2RKw/lJLwJyQ0JsRMh+A5cV58xdXb/SGrxYlgTA46pKbU1ktQEEriCE9TkvDeyxDBLzwc3A63PbvHqK4MyCS/NHTRNMfVBatQyE46m4bZjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386615; c=relaxed/simple;
	bh=p4uY4fX/EVD/lV6uhrAIZGE/M1rSgl/cQnwDh4Uao0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+8FSM2qbl8yauLYETCJSc3LNXRm6Z0JN3WqZEqflRt+9Re8kQqk931zbVrH21EwB9845QxvaMUvzcwRxXb/BHS+RIT3BUBE0XAxPKRUZahCsQYHWGyRqn/JikvsWU6qgfwZP2Iwh92L5sbM3mfWCe/ljo7MezufIOlVSTeCHxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyfffu5E; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyfffu5E"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso52139476d6.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 00:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780386613; cv=none;
        d=google.com; s=arc-20240605;
        b=j1rPbIPWGdbmIf4DtTWab0oClho2SzSU/1F+hpwQHyyAxYOfbT7+yjeID3u/sBwSSL
         AzughL+SJxn2dsuIUu1KiTYwt+vpb3GodZvQOh3lHmRuaJiiAhRbAX9+meIub1LXd0tU
         mZLaSq3xV4Zrjfb5l8vI2wPIOROu0fp2kvTxNNcWrlTzWErSZqib0e1yaJ6EZ8iqdV8j
         lqtLgaYgBWNsrSLZA2qluv2JP08ujNcCgMK0mhynJCUKaw/69Y2QN+fBscbl7Hzf6wXX
         kA+a4q4/eg5x+y969/y2P2DQucn8yh9JtiWgjqZBYftA8HwpU5/u9aU5b/CRlkDZWXjZ
         B0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zgL8tDN0iNZzPqDQjLO1yFoZYbXlgUsx/BWRwqMBeRM=;
        fh=skGGM1KscLIw5UW7rW+snO+ViGShI00S4TT/7BgiD6s=;
        b=OrfFQE4QyS7IW0uG4Txnx99X1P1t/A3bAVDwypFKiHrF6T6ctBXfduJsXnfXVQfD4Q
         2pwXPh67NQeFtZSrpyRqQnwgH2BguW/NvGYuO22twhtEguuyWGFaf8sVGSe/I3e7J6gV
         YMcJg9Q0NFe91U0CjLJpasfDK2aBdLiGIgKd6PWXnTjyhFneHRZp7cbEddfSgahWzTyo
         UBgGBKd4IXZOKW3ga2v8p5/nFsC0n3SRac27ckvqmcbFP+y48wQ0I2IWgRTBgecd5fKn
         +RdMekPJtKZNlUMLMYC297mnsydVMvUF6FF0XugG3FajdTwyW9ljRLqhJaPI/kS7vWsP
         lUoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780386613; x=1780991413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgL8tDN0iNZzPqDQjLO1yFoZYbXlgUsx/BWRwqMBeRM=;
        b=Kyfffu5EFSTBOsO+diSvdKZ2dSrZexeTAiS8/cygAv6/JCiVWlHSZd5FdxvrHQZhX6
         O6M+MJVjHs8VtuzzVnKhR69ZaTgsUgPq0ARySut6uwbM84EWth+rZ5VpQVjKj1J06/dH
         qXjRVBOGwWeRloYX3tq8fSfHq186YS7WjPu4vLzW1nvsO0IE7eCcEKK2qPs1d8YrV+mD
         bieTSvIdZ6b73jhlpmmTQRjxLDTZ5Z71G7E+SPB27TIoBoXJRQ9Ks0BFeWLEY/4B+cl7
         g0VdKzThoem8WhMb/GtAbbubziIVahJNk14V0t5FqSGq8UAAEMBsUjkStTEEXNHz9RaH
         MZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780386613; x=1780991413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgL8tDN0iNZzPqDQjLO1yFoZYbXlgUsx/BWRwqMBeRM=;
        b=TvUMP3OsF5z9B10ebFOvmSIDWKvhExueQ9EuVXkedQNFleCUsQnwRWYZdhDp2mJMsD
         QNISGI3ej+o7fILIaeHH/gUSNjb8FB8TKnGrOmc4tJCB2zzSC+o25rm8IiXf1H39s0Vw
         cepW33VqAR8pDCjiS2xU9xisjU9Cf2APqekGQjxMXVGKGryc+uAF+5VLSW2i+u3C0TWo
         Cl6v2aiO478WUY/mQ7bqYwEodBnYUwDyK8Fc08CD9TlEPHrMrQkgX/SCuBdKwSOnjsuJ
         wqdoNiRAVEoBGXBtXwZpTqDXsoyNRlomC+oXmPLsRJMW5C4agcZYpd3nW+hgybOxrbHF
         PDww==
X-Forwarded-Encrypted: i=1; AFNElJ+y+bf+lz0Zc45r52oZX2+2uC9oMqce3HulkOhFs6DPSb0n1/YjQPaGDJUhkcgfQp6QVRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzfClwp1wOjMeHBjvwAewNjKQrjqkb1eb8XYbdPqDcdD3Mr3r
	Q8J8tDjTljG/QeKaIAkUjz/oGjXHQL8WrsNMSUCUZbGbw3R++nwbZGIXYN2pIGGrLQgHsSP/BjQ
	n9irctAQOrkT6iFcbimg/qE1pfhAxeLo=
X-Gm-Gg: Acq92OG7Pt6fNX+PVrGQ/u226sSQSmVBivrB1w1enX8RxUiMxkiMzs4g5IEmg9DHhwk
	mBqgYTWPwu3Z3PVj7S2cbk8/rAYiEInjfcbu49qwyP9Svl5iDBNc4fAA/DW+z+bNzEKO//4MLF1
	CiuusmSa8R4ISHg3WZ4+agfstOzmO8R8buXJtU557pYFp00BGCOY8We3XXqjK8prScbfodDFvqS
	9/Hxo2rzYfA0X4dnSHdxvVfvCTTN9UGKP7fCV2KejpgX+a2tJAv4ks1fFlpE5TlkwIbN5ofvlnx
	I3HwIiaHQSF/m1LR9c0=
X-Received: by 2002:a05:6214:5412:b0:8ac:7d13:d189 with SMTP id
 6a1803df08f44-8ccefddd3b5mr260805056d6.41.1780386612773; Tue, 02 Jun 2026
 00:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
 <20260528032234.1322565-3-ewandevelop@gmail.com> <8890aa54-b119-4040-a508-e71706405ae2@linux.intel.com>
In-Reply-To: <8890aa54-b119-4040-a508-e71706405ae2@linux.intel.com>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Tue, 2 Jun 2026 15:49:40 +0800
X-Gm-Features: AVHnY4JsC40RGyIXT-rVlTlz95bhtzeQIMB45M_Ws2q4offsbD1fDY9ERgEcCVM
Message-ID: <CAG2uPc49SdVGYwHjxAbRRuk30k2hEfHG-D1wdJyFB-E+F69X5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, 
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:30=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.com=
> wrote:
>
>
>
> On 5/28/2026 11:22 AM, Ewan Hai wrote:
> > Advertise the Zhaoxin CCS (Chinese Cryptography Standard) feature to
> > guests via CPUID 0xC0000001 EDX bits 4 (CCS) and 5 (CCS_EN). CCS groups
> > two user-mode instructions for Chinese national cryptographic
>          ^
> Nit:
> It's supposed to be replaced?
>

Good catch, thanks. Sweeping the series I also found the same
"user-mode" leftover in patch 5 (RSA) , "provides two user-mode
instructions for modular arithmetic on big integers". Will tighten
patch 2, 4, and 5 to "unprivileged" in v3.
