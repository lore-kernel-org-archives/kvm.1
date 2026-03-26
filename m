Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529D3A6EEE
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557841; cv=pass; b=im1AbFgGHMvnJfqMOQn1OYXyfBfFW5MU5VL1yTHoaoJUAf16aJu/lzMiQTfndugHYFKh4O7qxmcfxiwN4MB8ntRBXTTpiB0mzQNa0LlWnUMKLSi3FjTRJrrAaQy2l5NpvRRsY8PoOYlKBfqt1dcmYDPNwDaruLr/Qq4E0stH+Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557841; c=relaxed/simple;
	bh=PeaSOVbGjvcbPrM1ej8GhDm0pQojiKvmqm8K/+z+B5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRfdsfWqkKPeoakbfWPJUkSkNHVIqSXApQm9BIakK79J1D1QiXGzvsWeMNlzhUoUqFK/yc7TAd6Tk0htopMS97XrKXwSP4DqP5oNmSLZo8tgcdGdqhiGFiamHLFdzOyqSVGTr6ZR+zwlKGe1cHuNMg/9lTgGYNZ6ImIZ6hJGh0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piX9Xtl3; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piX9Xtl3"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so1569701e87.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 13:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774557838; cv=none;
        d=google.com; s=arc-20240605;
        b=iCp+Pxazmzy78oxLM6yvT0X/Vg4J82Ezuu7MrYwHWjjiPEimpfyCud2q1uT6os0QwA
         JOkh1fH3NO0ooMUm0zHanWBo6aByBeeWXX2VhMCYA+lpE+L1Gj5hVmhxfgmNyNgw7i5k
         KEsF75wsrhJWdl0WnidHdzE+rxS/d6m+YXaEsXhLLtmIjVU17uvROvLV++OakIZw3JSh
         7WjbSMCVFqxFEMts+F460uCUBcKjdojbz0q716NQyy5EBHF2DuTJWA4hMa1kVey4gOpi
         llBNhykVV6mPIhjUeUYRbfA5WjBcN+2QqtFYBKpgKMONObyUKtKsBkGuUgEe3SCE9Kn2
         YHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        fh=+Vui8rNvya0Dd/dyrB5z61nHR/tTF28EXnoxcfsr6nc=;
        b=Todq5vpNGowMMVMOpZXi2Kz8uKwlNUZZtbwM3qcMF5bxHe4edCS70bG6y9osnny+Zg
         1s3Xo3oXBDTLgRxVFDECBQFRLWRH5UMHoP2qmFLp3GMBCkj05YDekuijFbHNqQyX+ely
         nOPa0Bdn4X5YhSQQB6LrJNw4u3gJXNieNzMXDK3X1Vqld+cWV8KZrDsEABj5E94QebSd
         ePYfbY5vgyYz58cLRR9ZjxWwiobzZ7iJ7LWxE5lk1Il3OdkyNa3Xl2q2Mq0mfXwC/843
         p3V5neKbBQibif4zTo8AewjbgP54uHCpdzDU1xrQwg9kxKTGNspE0xyEQxZqdaR6b2Z8
         tQIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774557838; x=1775162638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=piX9Xtl3iaNv8uRfxNguwwZybMuQycDIDPJDH0KJMJLN8uO4MO9qljp+6Um2fxBy0W
         DvbbxR72etHfe2JSvVkW43pq0jujJGTwdK6ZIn9fYJxI0JEyQIpzWNhFE+UPxqAXCFOx
         muZ4ven/Q02Rnfe0TNN5n2BfIDJfc0qu7dlulBOX+4IMwpRmLZHE4SKf/IolDO2ZGwry
         SzjXwCdA4gxJYubVTk+stqy1YCCmBeW+ZAgNmOUYeO3y2mXlphgmGYGEPOoUqpKw5HpR
         Ie5nuyrjnlTAW7NHJdpmZrOjV/IfjDvFPmsknTUTQ/VJT8MbysYMuKN1aoCVotxvyED7
         uSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557838; x=1775162638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=S1bo+sOuylGFE8vFk5BKGoPku56/ciIkcWZp5ob07ydhbl9O5p3SvDANUp/Kcie1CH
         mR799rOUinwFmp7SnGMzr2RQWTMnP5sgP5msnEyR59ydkOjA/WBFUbgtydIfnRa8Zl7A
         +Ecx68TRB3EvSsV+n7H/d9Hx4djTVT3tfTtmKxc2jM3Hb2FNZiBQl8OlJLxFUmPeboMG
         m/A2Yhg62bWlVekiZiYkpCqbQZ37fi12g/FkF/vYgQJLZUBlZtjvAhwTt8psN+6WgZu9
         jFW8Xa2BBLSaE6xHW7tZSeDB3TFtE0ssC4Rg2hBVUCipRYp/x26B20bUwzzWhbd7F7Se
         j8bg==
X-Forwarded-Encrypted: i=1; AJvYcCXfAMScuAoyiTqVRkiLqEenpWH1VaHXcxWx4/4LSP0T4c433F1CxhD7eYr5SNxGuK0NaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznsb037Z5J5yX8X1NPFco1sGL/Rfw6d+G6rYqQoG+vWozmgWlI
	BJxfIr29R29fftLUx58kUgvNBrlJ0T7Sxejqk+xbHvsKWshC3NZzjjQutBYP8e/39FRIf7Dg6p2
	xYyCLC3WK2ux0UKp4fi0CKI018hrLznJ9dts6V2rI
X-Gm-Gg: ATEYQzxkRHDKJWlw/n687NkPuRQHIsZKSne/fbuND+mD/dge97x/fyes7Sk0mcNu878
	VAz/r5nmAfcfbP5PZvHPDIjKIS1CwFYnXBrKbMyk/miuNaXYE7A02x4g3aEBs+NLBfDNBQ0wcW+
	tv9BilgGZ2/bZaX/jNUYjxphcuZotRcvomt43shvoWHXh3VV2x9lTHKZyYu3a2mZAn8WIylYlEi
	bUt2xbPK2ZGe99P6jRJOqXng6NIDfqVb88pLeID0lyHjmGSSjoDtT8zH8tMTya9sTg3c1tIRI20
	m9Sm4ROW
X-Received: by 2002:a05:6512:10c6:b0:5a2:a5e0:2da2 with SMTP id
 2adb3069b0e04-5a2a5e02ec7mr1094413e87.8.1774557837156; Thu, 26 Mar 2026
 13:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 26 Mar 2026 13:43:29 -0700
X-Gm-Features: AQROBzDv95n65Jfr7km6DKOoUBuRrbrSOHrGu-gele9pXf1C5O1laHd_UCbivjU
Message-ID: <CALzav=f4--Kp5vXz5zrxZR3WVsa9T1GF4NFFtuf_Q5ESMHmWwQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO
 device files
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> This series can be found on GitHub:
>
>   https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v3
>
> This series adds the base support to preserve a VFIO device file across
> a Live Update. "Base support" means that this allows userspace to
> safely preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
> and retrieve it with  LIVEUPDATE_SESSION_RETRIEVE_FD, but the device
> itself is not preserved in a fully running state across Live Update.

Apologies for the large number of people who got added to the CC list
on this version of the patchset. The changes to
Documentation/admin-guide/kernel-parameters.txt in patch 4 caused
scripts/get_maintainer.pl to CC a number of additional people due to
--git-fallback. I'll fix that in the next version.
