Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C2D9EDC
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862972; cv=pass; b=rvUGSP06bvazi4aiWBe8NFjeQFVWcWw//FjeTA543exvIMBhTbvY0p0aSZOxtyglSxo5gWWx9IaeEAolY/zDKW7mBzt++rUe45B0DLux8W/4E02YLexZLc+ReROqWVOEo1MseO5WhoSZLIXffc8Jxm6zZ2cyE0K9OQ9VCjRnVQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862972; c=relaxed/simple;
	bh=v/sc0XsZC038Vuii3xonWYoG3iLN4hTxE3JZFsfOJQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IalH7rTp1fd08OuwN/kVYklLRf9oLwS2IHShfDKMs1HwzjWljRXUbDEKHeEHP55atraAO2vZas+HF2Ueici5pSn10oShdWw8vS7oC8mQUKU1jYiBxKwwKkLbEB9L4PlJY+xlAf5+wxt1kzauj1VHoan8THS81iNWpu8D6j/nQgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZWhy84+; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZWhy84+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1758a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 20:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784862969; cv=none;
        d=google.com; s=arc-20260327;
        b=ddKqm4aLAALw+vT/N6Pzvb86MVGi9heoEsgoTbp+gsCNXw2HSNFjGp4ifOkkaNvXmR
         /hPdcRQJbZliTxOgy/tqH65qIqEgd9U9cFXLswLkF5G12PAHirvTg3YlntQFkx+bNYgA
         FmO4WMEKko7VxyYSisfRtT3eEQpq1GU6HBUfgZoZTxm95r5qAPwJdvCsli910Fn1mmm5
         XLQlcNYiAdgKhDyBnNec8QrpxjS2h61G8Na45PymGgs72+/G/X1VV24FtP4UGONLtdzD
         kkJlb0Gt7t3nWdSZKrF7jbC36OOcImDWXiTG1UieimGpzurZldRRFh7WrUDRR2XXAb+m
         S57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/sc0XsZC038Vuii3xonWYoG3iLN4hTxE3JZFsfOJQQ=;
        fh=KRFwJxprR9Pj3tlpnsfUsTzB8+HhRpRlMVlAdvHf5mQ=;
        b=jvnkp96tXxR2UJGPP/ToncDlaY7NryIEBDhuLJBfx8F61xv3DBWi4BZAzu0j1OPtW5
         rDrC3FVnd+yGJMZw1OOc07mx3/bAPsjjOqHAXRzXoIYMtKxtDTGT6ScFYWfI+3smgz6F
         Kp9/VdXQUoNsZuhq07+rnULNvzmYVbtEn7tj2TVFcWupd1Gs8ShZ/JrMg/w2X30PIUZW
         ginJDTqxEO5gYQTKDrkh6HGuVaPWSluDdJciaAZ/3yxse7wdFrKsfMkzrVCEogeILXYs
         xEAsunMN+xcKBXJxyRx3fqZVpH/B1APeRDL1Jv+n1gbFKcHfWUKZmnagrLjnaovZjTZj
         ucig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784862969; x=1785467769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/sc0XsZC038Vuii3xonWYoG3iLN4hTxE3JZFsfOJQQ=;
        b=iZWhy84+FyHzawgzbJO9gdb8trAkFRV7YYDOipY6r6wpt0/y7zLZZLb9LUOOidiOkf
         Htq3XgZAHEa6c18e7woTwyCjr7SwzqB0Ji8uyWgxpfYfG3X1imSF4tdPxTY/k0schNkA
         /vy+raUWl+NBQfistu1f3+TYomXR+UxkLgg97Z6L59LolNaTUjeEzWEx8pWWO1EdFLK1
         fiQhJ6k/SUAJCn13iYiw2x+bL3tvNWL3io83zIqANIxxeq0YD5/+U6CpoPDMwyg77rQt
         vbkVvANqAigOUAJPvV6yRm9ZLs3KVWtv1JmeH7fxuEY5VXn5l+fLLSdTE2XSWAz5qV0J
         F5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862969; x=1785467769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/sc0XsZC038Vuii3xonWYoG3iLN4hTxE3JZFsfOJQQ=;
        b=oDHEn0V40MLTw8U+PoRuc52uVWVcAR8t3gi533d0iiDHmTd9c8O5eJrraje8Gs6S5R
         0AaX1gU1DpoDW6xbDsYZAKx8pqfKHAIwqb9qybsWysoeWvD/u3sGrhcE/5Mc2nqDWoca
         3fDkYXrzvzOR+uSnNeMJb6iY39HtkFANHOtYPbWKtAxaJmXZVKjYuqMPAtXR4fIQcKY0
         Z5YZw7RR4sJ0Rx81pGMnC1UtTAVjZtlV35u7OcaaywNNT0PqGZpXQmYf1T2/t/KMwqo1
         aRSfsTX99i3GO0o2833FC9ZAtFP+87XdkDDIKe6s/io2MGEvJzaUJs8vBcetM2udgr/t
         87yw==
X-Forwarded-Encrypted: i=1; AHgh+RrdlYFkzLfj/6iMQwiCHb5JNZXRb6m3VqvxKc5BeLRmQJNKLon2xLKz9uuYP8zvZpS4/As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcfFXpKK4Dkwb9JzY4sJMlHFjScpBJSVK3t+5mhmWzxG80ufv
	YJxvs4DUvY2JuDwZ7RLCsOIUmSxYYvnZTtyND5Wv9pswHxJrGyiM+i1hAZXFSGuDMslx4ZG9fOt
	8TCICYrQ9yS7IEVDzru9lGmtbVx07jRD8N6XdicNp
X-Gm-Gg: AR+sD13absEPPVZTLi7XOXD3hmTbRvuL3Rx8Lf35vf2gB2zOD2eqM1nNrzO7bqc/1kd
	VhRezluJxcwtStzB4bM+FowpRFeD7zs7HL4BUvx6zsmj8DeRkX6YYxxXRNdCQG2dT6Xl1LXmtSa
	yVAUrVezz7rnKxzERCdIzTf8VtQwFlOgwlB/89i4BhOWcqcmMytjQsnVWCG/Rq2Cjquld4VzF8r
	5rSxwUjL0M6onbYP+hVmOGE79c0gqf3PpfCWzQUk+IhKlBC+Xx7pPnOggRi5hvVQGf8a2+Y
X-Received: by 2002:aa7:d759:0:b0:69e:98c8:c71b with SMTP id
 4fb4d7f45d1cf-69f8ee93564mr41477a12.6.1784862968443; Thu, 23 Jul 2026
 20:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-6-zide.chen@intel.com>
 <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com> <6fa18abe-4cb0-42e5-88f6-880a9ecaf769@intel.com>
In-Reply-To: <6fa18abe-4cb0-42e5-88f6-880a9ecaf769@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 20:15:56 -0700
X-Gm-Features: AUfX_mw_MRUm546pWvq3POwaQW2qZz8fmc0TuhqAa9xpaVpzheRFPpUH1rfaENw
Message-ID: <CALMp9eSYcAoKR+ZiSe2R1-Oq1SAEfHJrHSXKzSvvyzcZUMTdHQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:44=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
> The SDM guidance that "fixed counter 3 must be restored before
> PERF_METRICS" appears to apply only to a running PMU, which is not the
> case here.

That's not my reading of the SDM. There are three bullet points about
save/restore at the end of volume 3, section 22.3.9.3:

* PERF_METRICS and fixed-function performance-monitoring counter 3
should be saved and restored together.
* To ensure that PERF_METRICS and fixed-function
performance-monitoring counter 3 remain synchronized,
both should be disabled during both save and restore. Software should
enable/disable them atomically, with a
single write to IA32_PERF_GLOBAL_CTRL to set/clear both
EN_PERF_METRICS[bit 48] and
EN_FIXED_CTR3[bit 35].
* On state restore, fixed-function performance-monitoring counter 3
must be restored before PERF_METRICS,
otherwise undefined results may be observed.

The second bullet contradicts your claim above.
