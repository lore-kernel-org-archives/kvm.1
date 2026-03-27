Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEA22D7B5
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621217; cv=pass; b=oFpesSQg7OBLLTJEbwrxCvkK21htNQsX6qhQOJzOe4CPg3WNgozM0l0vabDCipzuuTobtD8hHU/HmcBPfPsXxuIA9e6RS3H94LpnIk5d0rjpQPyBogttr0mWU1KnOhlWCbZzky4/3Z/A34dWrX62YBGDByVvzcpju1DFmCc0/gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621217; c=relaxed/simple;
	bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHm4c/OQBwum/ZLr3cOISVM5mbvEOH5oKNw8udS/KHHxgr7Hz1/93GrK2qzIx7yPC47kw+vzERKZMoFRZlNREn476mOvmS5c9LY4527fVx6gfJGTw9PmOpJx1QCkky2awztje1QZ5Vv5BLIFlg//4od7pJOlyT6cdooUcwAapcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QP/5ksUI; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP/5ksUI"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad9fabd08so2337834d50.2
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621216; cv=none;
        d=google.com; s=arc-20240605;
        b=MPk7V/9d93InEYGkNt80/xVOuebG79rBC/f+oZKp1CfvfVM8ePSNWWVKPMVWiZZpBx
         pTSrTvPN5ilP565BNaooRXoABRItmdgO/TE6SoLHmJ8Se0iThEtNyP9SgaMxO0Y5N+jM
         UZuyLlh/WmD6fc+SX+CY3i8EIuRc26BGupwefFRlvGrsrLnuo8XV4w/j8n2DuZ7631Uo
         teZJFZ5cz84urXgS1nezUujIHsE7Ql35DXiQvnaCufrG36MfYIvmEPUbr1XgYTeKdCRO
         vLxsLjoz7GObhy/Bn0vgD0h0nDlgGZfJOoGWj/3ZfSXIv+qyew0l678HUsSXV2OUL5Nu
         chkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
        fh=055iueh/FBmoe5A0bzxqGXu5i8jl1IeiUG/EXdr5a+4=;
        b=JZsPAUTpgzc+Y9g/ldbKYZIoHQGH0cvk/Yxt+iCCUtY/W1h6qfmgLWoqhKgZAs2bBX
         6Sors+K+0H/fffIL7c+YL9PpcGY36Ztt+ToFALJmfgG04apvU07yMzuby0J/chFrype/
         1nc1iclhS868OuU3ilAmSPOYHnHDq/6iaAVyTYMvg1Ycxk1q/BTSJZXWuRZkyGvQ5lG9
         yq9JT13OTO4vg4clfkY9pCSv8/fOZhyJ6wGAw35/CS/AqwNjQ9VdHWEfux0Tz8E9nzbF
         ESC58eQ9ERF9te1SeND50wxOG9nxsS/TRZCg7MW+CTiryKFn9Q3WA8aKOud1Nueytfom
         3oBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621216; x=1775226016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
        b=QP/5ksUI5iH86uWmS4tGYX2AWzs6q0uK/Mrj149f+o5pu09fEpJQBezLpk2j9r0w6Q
         r3V0vS0eG5iZnimXIe7qQoMdFa34bwhYhMl3KrbXEhR64Cyb2PAR1yExM0YeFZ2dQ/dL
         TXo9NRGoNkh9zdajY8sAuaQ/Tfd3LgSFWBMxDwG9c6lPMOs/IJq4ETfLYoWlwq4jfcSL
         BrijCjW6wjTc143eaqKeOrg8jMia4w1FMDsKr5kZtPv6m6CdqEoPZFSeeTDSmAFpo/w/
         ISBy5bDSfVL0+JpEffuTHsYrcjRbWpXDk3hxpqmghV3T6u8cSeAdPXgYmwV4fKkTQkUc
         EIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621216; x=1775226016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
        b=g3mdXUJILNlp2q8Fi0/hwk950X4WAFYTAFU/PRYF7QYbLdY4DpNUkG+aRcnFwzyfwW
         0Csu6Z4L+ZBQHyjzHXpAXiIT1IdryWA67/MRvGrUh3ZWXVq8aRhRkLdM8ReU6KsRNE2y
         MWtIKyUqn8+koD+f84sLvySI+uLeXZKgLEj+ILctOQ7F9ExfupnRHUG130BL1KFbMq1j
         P/yrFgxQIda54BrLFEgORStZaDGHIw73Md4ng9GP7puSid4nu3NYVovTQHQGIn9fJDOD
         1efkwuBiqcyY5CYCy1kE/wLZvnCMMPnwGCOl/JGrW3rR0kqgs0wzBzPuBfiWyL4WdSnl
         BqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXjWD2qxJ4Duc6RwoToHbXkIUjCB7PnXHpO17Ti9BCAVF5r4da5LMXbf8Mk/tklHJu4ZJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP/eo3tbMSCJXE6pL/LsRB7nPJ2VZJ88uwOv0hFt1bnnHz6Fj
	StSjIurCNabL1IKHLVK4Gb888McBhOeKQGMhCSxyoWISJGYOe6ba/cCnaHuRgjyFrTifS4e0JBg
	w8MJoIzECvQb8m5rC1eFa1T8fVr50vy4UAcfD6cmDWw==
X-Gm-Gg: ATEYQzyKsM8lCR6t3zqpzuxro4GiG/R4xxI2Gj3OH4sJhqIv2kgAV6uRdj8/B0LNUhm
	BkAI8+mXBVNsd0DTbqEw979QxdiurkrPeQDGN+gM6/fMq6aBzaVdUgwLjfLqqdNuMGuldtYhVDl
	QYCd5EN9bUAFGCx+XBzh+IWbT8ikHR75KEgzX0fY4SvPFKBODRBH4adX51Ga1UNt+m3apI3kbzW
	J126MB6A2/II07R7AoY+BLkg1QebpeuM9Tf9lvrUf9M7WkY5rKDA8UALIDk7Xr3QID2UpwHTG0i
	j63FvNaPaJzbl8uazYBzVjcHIdE1NECQlt3W7FxcCkhc5zC8JF8SUYVQxuE68ScVeVgTMTulafx
	iKg==
X-Received: by 2002:a53:d60d:0:b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-64ff73b6081mr1959808d50.52.1774621215306; Fri, 27 Mar 2026
 07:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-14-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-14-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:20:03 +0000
X-Gm-Features: AQROBzBFRtQAiDsGDqgRuOyZis6C54lKjmWtnXZGQUZFVhOVaki8E6WZtmCjCXU
Message-ID: <CAFEAcA_B7hU2+YXEem-9-avrz64cvz6X=NB+bb8hfdMu9PdgGQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] util: Remove unused sys/param.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
> basically completely rewrote the path handling).
> Now we don't need any sys/param.h defines.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(If you need to do a v3 for some reason you could merge this
with the previous patch; but it's not worth respinning just
to do that.)

thanks
-- PMM
